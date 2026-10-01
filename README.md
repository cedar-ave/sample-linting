# Linting with Vale and markdownlint

- [markdownlint - Markdown formatting](#markdownlint---markdown-formatting)
  - [Documentation](#documentation)
  - [See all markdownlint errors in a directory or tree](#see-all-markdownlint-errors-in-a-directory-or-tree)
- [Vale - Spelling, grammar, style](#vale---spelling-grammar-style)
  - [Style guides](#style-guides)
    - [Example](#example)
    - [Customization](#customization)
    - [Spelling](#spelling)

## markdownlint - Markdown formatting

`markdownlint` is available as a VS Code extension. Rules are customizable.

### Documentation

- [markdownlint documentation](https://github.com/markdownlint/markdownlint/tree/master/docs)
- [Enable and suppress rules by page or inline](https://github.com/DavidAnson/markdownlint/blob/main/README.md#configuration)

> Configuration file: `.markdownlint.jsonc`

Common rules for reference:

```html
<!-- markdownlint-disable MD033 no inline html -->
<!-- markdownlint-enable MD033 -->
<!-- markdownlint-disable MD044 proper name for <word> -->
<!-- markdownlint-enable MD044 -->
<!-- markdownlint-disable-next-line MD028 no blanks in block -->
<!-- markdownlint-disable MD041 first line heading is h1 -->
<!-- markdownlint-disable MD024 no duplicate heading -->
<!-- markdownlint-disable MD001 headings increment one at a time -->
```

### See all markdownlint errors in a directory or tree

Install the markdownlint CLI:

```cmd
npm install -g markdownlint-cli
```

Run this command at the root of the documentation repo:

```cmd
markdownlint 'articles/**/*.md' --config .markdownlint.JSONC
```

> [markdownlint-cli documentation and options](https://github.com/igorshubovych/markdownlint-cli#markdownlint-cli)

## Vale - Spelling, grammar, style

Vale is available as a VS Code extension or as a standalone CLI. Catalyst is not using Vale Server. Rules are customizable.

> [Vale documentation](https://docs.errata.ai/vale/about/)

> Configuration file: `vale.ini`

To run Vale without installing the VS Code extension: From the root of the documentation repo, run `vale .vale.ini articles > linting.md`

### Style guides

This repo represents a custom style guide.

However, Microsoft, Google, Vale, Write Good, etc., offer [Vale style guides](https://github.com/errata-ai/styles#available-styles). To lint against these or other guides, download them to `vale-styles/{style-guide}` and add the parent folder name to `vale.ini` (e.g., `BasedOnStyles = Catalyst,Vale,Microsoft`).

To customize application:

```html
<!-- vale off -->

This is some text

more text here...

<!-- vale on -->

<!-- vale Style.Rule = NO -->

This is some text

<!-- vale Style.Rule = YES -->
```

Based on this tree in the repo...

```plaintext
root
  Docs
    vale-styles
      Linting
        All.yml
```

...a style rule would be `Linting.All`.

#### Example

```html
<!-- vale Linting.Spelling = NO -->
Text
<!-- vale Linting.Spelling = YES -->
```

> [Source](https://errata-ai.github.io/vale-server/docs/ini#in-text-configuration)

#### Customization

To preserve the integrity of the `.yml` files in downloaded styles, copy any `.yml` file you want to customize into the custom `vale-styles/Linting` directory. For example, if you don't like a word a `.yml` file in the Microsoft style checks for, copy that `.yml` file to the `Linting` directory and remove the term. Then you can exclude the original `.yml` style in `vale.ini` (e.g., `Microsoft.HeadingAcronyms = NO`).

If you don't do it this way and, for example, Microsoft comes out with a new-and-improved style, you can't just replace the old Microsoft style files with the new ones, because you customized the original files.

Custom `.yml` rules can be created with Vale [extension points](https://docs.errata.ai/vale/styles#extension-points).

#### Spelling

Ignore file: `vale-styles/Linting/spelling-ignore.txt`
