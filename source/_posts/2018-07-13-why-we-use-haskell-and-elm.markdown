---
layout: post
title: "Our use of the Haskell and Elm programming languages"
date: 2018-07-13
comments: true
categories: [Haskell, Elm]
---

Over the last year, our team has built a beautiful and advanced Smart Cities system using functional languages. I wrote this document to explain our technology choices to stakeholders and partners.

<!-- more -->

## Introduction

A number of programming languages - Haskell, Elm, Ruby, JavaScript/TypeScript, Rust, SQL - are being used in the construction of our systems. This variety is common in industry, since large software systems are increasingly being built of several smaller programs (including browser applications) which collaborate via HTTP and REST APIs, and therefore need not be written in the same language.

## Industry trends in programming languages

Programming languages and environments have evolved continuously as computing power has increased. Java and C# used more memory and processor cycles than C/C++, but came with virtual machines that could run code compiled anywhere, so they became popular. Interpreted languages such as Python, PHP, JavaScript and Ruby can be interpreted fast enough that their programs can be run instantly so their behaviour can be observed immediately.

Those changes have largely resulted from being able to run programs faster, but importantly, programmers now have enough power on their desktop computers to use tools that can inspect their code before it runs, perform sophisticated analysis of its structure and implications, and use that analysis to provide feedback to the programmer. In this way, developers can _use_ software to help them to _write_ high quality code!

The fundamental design of most programming languages - including Java, C#, JavaScript, Python, C, C++ - is unfortunately such that this "static analysis" of code can only provide limited help and assurances to the programmer. It is therefore common in the software industry to deliver software that exhibits many bugs when it is run, or software that is expensive and risky to change because it is difficult to know whether changes have broken something.

A separate category of languages were built to allow static analysis of program correctness at development time. The most mature of these languages, [Haskell](https://en.wikipedia.org/wiki/Haskell_(programming_language)), has been continuously developed as an open standard since its first version in 1990, and is seeing industrial use by [companies such as Facebook, Google, Microsoft, AT&T, the New York Times and various investment banks](https://wiki.haskell.org/Haskell_in_industry). In turn, features of those advanced languages have influenced newer hybrid languages such as Scala and Apple's Swift. [Elm](http://elm-lang.org/) is a Haskell-like language which offers the safety of Haskell but produces JavaScript code that can be run in a browser. Overall, these advanced languages are set to grow dramatically in use.

## Choosing the best tool for the job

Mainstream programming languages offer some advantages because they are in more widespread use: expertise is more available online and in the labour market, and a wide range of code libraries and vendors support those languages. In our technology group, we use a combination of more mainstream languages and Haskell and Elm, following the principle of choosing the best tool for the job.

Some functionality of our system, such as managing users and access control, is a commodity for which widely-used packaged code exists for the popular Ruby language, so we use that. In contrast, the novel functionality with which our system provides its unique value to our customers is the ability to process and query huge quantities of geographic data, and to explore it via a sophisticated browser-based visualisation engine. It is for these novel functions we have chosen Haskell and Elm.

## Haskell for expressing complex behaviour

Haskell has excellent libraries for integrating with databases and web services, and for building API services. Our systems pass all of their geographic data through an API server written in Haskell, and not only must this server must be reliable and fast, it must also be possible to evolve its design rapidly as we discover new requirements without breaking existing code.

Even when we make dramatic changes, Haskell's language design and its development tools tell us if those changes are inconsistent with the existing design, and they require that we eliminate those inconsistencies. Those same tools help us to be confident that we are correctly handling all the possible inputs and outputs, which we model with Haskell's advanced datatype system. The tools force us to consider every possible failure case, so that our programs will handle them appropriately.

The net result of this has been that we simply do not experience unexpected errors in our Haskell programs when they are deployed, so we can deploy new releases confidently and spend our time building valuable features rather than investigating run-time failures.

## Building beautiful, reliable web interfaces

Elm has brought comparable benefits to the development of our web application interface: with a complex set of interrelated controls and information on the screen, it's important to maintain consistency of display, particularly when new data is being loaded periodically from multiple servers. It is generally extremely hard to write such applications reliably in JavaScript, but Elm lets us program and analyse our web application interface code correctly, and then it produces JavaScript which runs absolutely reliably in the browser. Our users almost never experience programmer errors in the interface, since the Elm language and tools ensure that we specify the code's behaviour correctly before it even runs in the user's browser.

## Language choice and our team

Both the Haskell and Elm code-bases are worked upon by multiple developers simultaneously, and often experience significant change, but the associated language tools have consistently ensured that the team members have not accidentally broken each other's work. Even as our code-bases have grown significantly, they have remained easy to work with.

The pool of developers available in the labour market with experience in these languages is relatively small, but very smart developers who value correctness of software have applied to us and been hired because we are using these interesting languages. Groups using Haskell in industry universally report that job applicants are plentiful, capable and motivated: the developers who are actively interested in learning progressive ideas and languages are exactly the ones who will succeed in a fast-moving environment building a complex product.

Some cross-training has been necessary for our team members with experience primarily in mainstream languages: it has taken the team a little time to learn the new languages and how to think about our code in the rigorous way they demand, which can be unfamiliar at first. Good software developers learn quickly, though, and our smart team of mixed industry experience levels has picked up and embraced both languages rapidly and enthusiastically. We are quickly becoming familiar with the tools, best practices and library ecosystem of each language, and our productivity is higher than we would have expected had we used only mainstream languages. 

Industry support for the languages has increased significantly in the last decade, and is now very good. The Haskell and Elm software tools and libraries we rely on see regular releases and prompt bug-fixes, high-quality third party libraries are readily available for key parts of our applications, and online communities and reference information are readily available.

We are proud to be building complex software which consistently delights customers with its new features and reliability, and our language choices have contributed to our ability to do so.
