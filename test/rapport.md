---
title: Pandoc Container
subtitle: Technical specification
lang: en
author:
- Julien M'Poy
tags: [markdown, pandoc]
date: \today
papersize: a4

# Model
documentoptions: twoside

# Styles
fontsize: 12pt
colorlinks: true
linkcolor: Blue
citecolor: MidnightBlue
urlcolor: MidnightBlue

links-as-notes: true
numbersections: true

monofontoptions: Scale=.8

# Table des matières
toc: true
toc-depth: 1
lof: true
lot: true
tblPrefix: tab

# Sources
bibliography: bibliographie.bib
csl: iso690-author-date-fr.csl

# Abstract, thanks, etc.
abstract: |
    This document aims to present how the pandoc container works.

    _**Keywords:** pandoc, markdown._

# https://tex.stackexchange.com/questions/7546/how-to-get-latex-symbol-in-document/7549#7549
header-includes:
- |
  \usepackage{lmodern}
  \usepackage{xspace}
  \usepackage{xltxtra}
  \let\tex\TeX
  \renewcommand{\TeX}{\tex\xspace}
---

# Introduction

[Pandoc](https://pandoc.org/) is an opensource tool that allows you to convert a document of a specific format into another format. In this case, we use it to convert from [Markdown](https://daringfireball.net/projects/markdown/) to PDF.

You can use pandoc to generate presentations from Markdown files too.

# Markdown

Markdown is a markup language whose syntax looks like the following:

```markdown
<!-- this is a comment -->

# Title 1
## Title 2
### Title 3
#### Title 4
##### Title 5
###### Title 6

*emphasis* ou _emphasis_ (displayed in italic)

**strong emphasis** ou __strong emphasis__ (displayed in bold)


- unordered
- list


1. ordered
2. list


list

: of definitions


[hyperlink](https://example.org)

![caption](image.png)

> quote

   unformatted  text

```

This advantage of Markdown is that it is a text format and it can be easily versionned with a solution like [git](https://git-scm.com/).

### Mathematic formulas

Thanks to [MathJax](https://www.mathjax.org/) it is possible to embed mathematic formulas.

$$-1 = e^{j \pi}$${#eq:minus-one}

The format used to embed mathematic formulas is the one from \LaTeX. Use a single dollar symbol (`$`) to display an inline formula (like $e^{j \pi}$).

You can use `$$` to display a formula on its own line and centered (such as @eq:minus-one).

```markdown
$$-1 = e^{j \pi}$$
```

### Metadata

Markdown is missing the ability to fill in information such as author, title, document's language. This kind of information is called *metadata*. To fill metadata, you can use a prolog in the YAML format. The YAML prolog est enclosed between triple dashes `---` or in a different YAML file.

```yaml
---
title: My title
lang: fr
---

... the content of my document ...

```

The above example allows to build the document's title page and to apply some typographic rules that are related to the french language (`fr`).

### Images

![Microsoft Word's "Clippy"](sad-clippy.jpg){#fig:clippy}

## Sources {-}

<!-- shortened links -->

[rapport-technique]: https://github.com/HE-Arc/rapport-technique
