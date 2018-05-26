---
title: "How to use OpenCV with Xamarin iOS"
layout: post
date: 2018-05-26 14:40
tag:
- xamarin
- ios
- opencv
category: blog
#star: false
---

Recently I had to use OpenCV on a Xamarin iOS project. I'm writing this to remove few frustrating hours (or days) of anyone tries to do the same. Unfortunately you can't code opencv directly on Xamarin. You have to create a static framework using Xcode and write opencv functions using C++. Then you need to bind (map) the static framework to Xamarin using a binding project. 

## Steps

* Download OpenCV
* Create static library with Xcode
* Create binding project in Xamarin

## Download OpenCV

You can download OpenCV from https://opencv.org/releases.html. Choose iOS Pack. I'm using opencv 3, but the same steps applies for opencv 2.

# Create static library with Xcode

Create a new project in Xcode by choosing **Cocoa Touch Static Library**

![Choose]({{ site.url }}/assets/posts/xamarin-opencv/choose.png)

Next choose Objective-C as the language. Since we have to code this in mostly in C++ (Actually in Objective C++ in this case) it's better to choose the lower level language here. It's possible with swift but there would be additional binding steps.

![Language]({{ site.url }}/assets/posts/xamarin-opencv/lang.png)

Drag and drop downloaded opencv framework to the project.

![Drag]({{ site.url }}/assets/posts/xamarin-opencv/drag.png)

Rename `OpenCV.m` to `OpenCV.mm` since we need Objective-C++ not Objective C. Now create a prefix file from `New File ...` and following line to it.

```cpp
#ifdef __cplusplus

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>

#endif
```

Then go to build setting and add `OpenCV/PrefixHeader.pch` to `Prefix Header`

![Prefix]({{ site.url }}/assets/posts/xamarin-opencv/prefix.png)

Implement the following method in `OpenCV.mm` file. This is for testing but you can implement which use opencv here.

```c++
-(NSString *) version
{
    
    return [NSString stringWithUTF8String:CV_VERSION];
    
}
```

Goto **File -> Project Settings** and click `Advance`. Select `Relative to workspace` from Custom.

![Custom]({{ site.url }}/assets/posts/xamarin-opencv/custom.png)

One more thing. Now we need to create a universal library from this to be able to run on both real devices, and simulators. Compile the app for `Generic Device` and a simulator twice. Then use following script to generate universal binary. Create a file name `make-opencv-lib.sh` in Xcode project and make it executable by `chmod +x make-opencv-lib.sh`.

```bash
#!/bin/bash

lipo -create -output libOpenCVUniserval.a Build/Products/Debug-iphonesimulator/libOpenCV.a Build/Products/Debug-iphoneos/libOpenCV.a

lipo -info libOpenCVUniserval.a
```

Then run it by typing `\.make-opencv-lib.sh`. If successful you will see a file called `libOpenCVUniserval.a` in your current directory.

# Create binding project in Xamarin

Now put whole project into your Xamarin Project (This is not necessary if you are careful with paths). Then in visual studio right click the solution and click `Add -> Add New Project ...`. Then select binding library.

![Bind]({{ site.url }}/assets/posts/xamarin-opencv/bind.png)

Right click `Native References` and click `Add Native Reference`. Add `opencv2.framework`. Right click on the library and go to `Properties`. Add following string to `Frameworks` field.

```
Accelerate AssetsLibrary AVFoundation CoreGraphics CoreImage CoreMedia CoreVideo QuartzCore UIKit Foundation
```

Also make sure `Kind` is Framework and `Check` is checked.

![Frameworks]({{ site.url }}/assets/posts/xamarin-opencv/frameworks.png)

Repeat this with file `libOpenCVUniserval.a`. No need to add frameworks string there. In properties make sure `Kind` is `Static`. 

Now go to the file `ApiDefinitions.cs`. Add following interface.

```C#
[BaseType(typeof(NSObject))]
interface OpenCV
{

	[Export("version:")]
	NSString Version();

}
```

This is where you add your bindings.

Go to your iOS project in Xamarin IDE and right click `References` and click `Edit Refernces`. Search for your binding project add click `Add`.

Now you can use binded opencv functions any ware in the project. Use it as an object.

```csharp
private OpenCV OpenCV = new OpenCV();
```

And if you are able to print the version as follows, congratulations you have configured OpenCV correctly.

```
Console.WriteLine(OpenCV.Version());
```

You can find the sample project source code [here](https://github.com/chamoda/XamarinOpenCV)
