---
layout: post
title: Rethinking monorepos in the age of agents
date: 2026-06-13
description: "As the industry switches to agentic coding, it makes less and less sense to keep separate repositories when agents benefit from the broader context of a monorepo."
---

Now that most of the software development industry is switching to agentic coding, it makes less and less sense to keep separate repositories when agents might benefit from having better context in a monorepo.

Maintaining monorepos needed extra care historically, but now the maintenance aspect can also be faster with agents. You can use agents effectively without monorepos by opening an agent on a parent folder or referencing `@../project`, but having a monorepo is much nicer for agents and developers alike.

I think now more and more things from the company should, or could, live in a monorepo so agents can operate with better context. Years ago, infrastructure as code started to live in monorepos, but now I think there are more "X as code" things that could live in a codebase, where agents can help drive that codebase, and hence the company, forward autonomously.

## Branding as code

Things related to branding can live in a monorepo structure, like color palettes, logo variations, and the branding vision, along with guidance to agents through `AGENTS.md` files.

## Marketing as code

More and more automations can be done with agents, and some things related to marketing can be automated too. Imagine a GitHub Action that runs a few times a week to generate marketing material. Tools like [Remotion](https://remotion.dev) can run and generate marketing material for a vision defined in `AGENTS.md`, then open PRs for the team to review. Imagine a workflow where merging that PR triggers another GitHub Action to publish it to social media automatically.

## Compliance as code

Treat compliance as code and let that part live in your monorepo. Keep enforcement properly defined, and you also get an audit trail with git.

## Almost anything as code

Branding, marketing, and compliance are just examples. The pattern generalizes: most things a company does can become X as code. Sales playbooks, support runbooks, hiring rubrics, financial reporting, even strategy can be expressed as text, configuration, and scripts that live next to everything else. Once something is in the repo, an agent can read it, reason about it with the surrounding context, and act on it. The repository stops being just where the product lives and starts becoming where the company itself is defined, version-controlled, and driven forward.

I built [agent-foundry](https://github.com/chamoda/agent-foundry) recently, a set of GitHub Actions that can run agents in GitHub Actions continuously. Now that I'm running them on a bunch of personal and work repositories, it's giving me more and more ideas. I'm sure all of these ideas already exist, but I think it's the perfect time to combine them with agents and monorepos.
