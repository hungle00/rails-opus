---
title: Rails concerns note
author: hungle00
layout: article
description: Rails concerns is tool for using mixin in Rails models
published: 2024-11-10
uuid: d99f045b-f3f7-4408-811e-9701b1a13ce8
tags:
  - Rails
---

## Rails concerns note

A Rails [Concern](https://api.rubyonrails.org/classes/ActiveSupport/Concern.html) is a module that extends the ActiveSupport::Concern module. Concerns allow us to include modules with methods (both instance and class) and constants into a class so that the including class can use them.

A concern provides two blocks:  

1. `included`   
  - The code inside the included block is evaluated in the context of the including class. 
  - You can write class macros (validations, associations, scopes, etc.) here, and any methods become instance methods of the including class.

2. `class_methods`  
  - The methods added inside this block become the class methods on the including class.
  - Instead of the `class_methods` block, you can create a nested module named `ClassMethods`.

For example, a concern named `Taggable`

