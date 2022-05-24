# ROADMAP

Welcome to roadmap page. This page organizes some tasks and records what tongji-undergrad-thesis is going to do with. It would be greatly appreciated if you want to start up quickly and make some contributions to this project.

## Some Missons

1. build ci.
2. complete documentation / example.
3. solve font and style problem.
4. solve visual identity elements problem.
5. (optional) use \*.dtx and \*.ins files, instead of baked \*.cls.
6. remove "undergrad" from "tongji-undergrad-thesis".

and more...

## Get Involved Quickly

### 1. build ci

[GitHub Actions](https://docs.github.com/actions/getting-started-with-github-actions) recommended. As a CI/CD platform for GitHub, Actions allows users to do some operations automatically, especially doing build and test jobs. The way to define a pipeline (a concept in CI/CD) is to write \*.yml files under ".github/workflows" path.

About how to build a pipeline, declare runners (like pipeline node), define jobs in runner and even know more concepts in CI/CD, just read the documentation under [learn-github-actions](https://docs.github.com/cn/actions/learn-github-actions)

### 2. complete documentation / example

Now, documentation is identical to example. In [sections](./sections/), there is a not-so-standard undergraduate thesis written by [ganler](https://github.com/ganler), the original maintainer of this template repository.

It is important to complete a brand-new and excellent documentation, which is able to teach basic LaTeX writing skills and guide users to features implemented in "tongjithesis".

### 3. solve font and style problem

"毕业设计模板（理工类）" uses Times New Roman now. Font family and template style details are always frustrating. These problems are waiting for who would like to go further into desitiny.

### 4. solve visual identity elements problem

VIS (visual identity system) is also important for identity building project and it is benefical to promote cultrual soft power of our university. However, Tongji University did not pay enough attension to this important issue.

Therefore, we can not access official visual identity elements.

It is sincerely appreciated to make a contribution to VIS of Tongji University!

### 5. use \*.dtx and \*.ins files, instead of baked \*.cls

"Literate programming" is a essential concept of LaTeX, which means source should be readable like natural language. \*.dtx (Documented LaTeX) is designed to solve this problem by creating a combination with source and documentation.

\*.dtx and \*.ins files are used to unzip / install. They include \*.cls, \*.bst file definition and user guide. Know more [here](https://texfaq.org/FAQ-dtx). [pdf on tug.org](https://tug.org/TUGboat/tb29-2/tb92pakin.pdf) is also very helpful, when it comes to \*.dtx details.

Writing a \*.dtx file might be a choice which need to be considered carefully; \*.cls or \*.dtx, this is a question.

### 6. remove "undergrad" from "tongji-undergrad-thesis"

Unification of bachelor, master and doctor is a huge work and it has a long way to go. (Perhaps, unified thesis template would be created independently in the future, rather than being a continous part of this project. But we would be still delighted to embrace it)
