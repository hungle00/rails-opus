---
title: Concurrency in Ruby - Thread and Fiber
author: hungle00
layout: article
description: In this post, I'll focus on comparing Fiber and Thread and explain why Fiber is better than Thread in some cases..
published: 2024-10-15
uuid: d99f045b-f3f7-4408-811e-9701b1a13ce8
tags:
  - Rails
---

## Fibers and Threads

As you can see, they have quite similar syntax, so what are the differences between them?
- **The level:**  
  - Threads are created 1:1 with threads on OS.
  - Fibers are implemented at the programming language level, multiple fibers can run inside a thread.

- **Scheduling mechanism:**  
  - Threads are run pre-emptive by almost modern OS.
  - Fibers are referred to as a mechanism for cooperative concurrency.

**Threads will run automatically, they are scheduled by OS.**  
With Thread, programmers are just allowed to create new Threads, make them do some tasks, and use the `join` method to get the return from execution. The OS will run threads and decide when to run and pause to achieve concurrency.

**Meanwhile, Fiber gives us more control**  
 With Fiber, programmers are free to start, pause, and resume them.
- `Fiber.new { }` : create new fiber, started with `resume`
- `Fiber.yield`: pause current Fiber, moves control to where fiber was resumed
- After suspension, Fiber can be resumed later at the same point with the same execution state.
