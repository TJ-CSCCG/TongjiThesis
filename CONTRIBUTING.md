# 贡献指南 | Contributing

## 仓库结构 | Repository Structure

- **源文件**（`style/`）：`tongjithesis.cls`、`tongjithesis.cfg`、`tongji-circled.def`、`style/font/*.def` 等定义模板本身的文件。
- **文档文件**（`chapters/`、`main.tex`、`taskbook.tex`/`proposal.tex`/`midterm.tex`）：`.tex` 文件，用于展示模板的使用方法；`taskbook.tex`/`proposal.tex`/`midterm.tex` 是任务书/开题报告/中期报告的独立入口（`doctype=taskbook`/`proposal`/`midterm`），正文由 `chapters/taskbook_body.tex`/`proposal_body.tex`/`midterm_body.tex` 提供；其中 `chapters/01_guide.tex`（模板使用指南）编译进最终 PDF，是权威的使用文档，`README` 不重复其内容。
- **参考文献与图片**（`bib/`、`figures/`）：示例文献库与封面/页眉等图片资源。
- **构建脚本**（`scripts/`）：`update-preview.sh`（生成预览图并推送至 `TJ-CSCCG/TJCS-Images`）；版本号升级已由 release-please 自动化，见下方「版本发布」。
- **CI 工作流**（`.github/workflows/`）：`test.yaml` 为构建矩阵（即本项目的测试套件），`release.yml` 负责打包与发布。
- **配置文件**：规范开发与使用的文件（如 `.gitignore`、`.latexmkrc`、`.editorconfig`）。
- **AI 编码代理约定**：详见 [`AGENTS.md`](AGENTS.md)（架构说明、命令速查、行为规范）。

## 如何贡献 | How to Contribute

### 寻求帮助 | Asking for Help

我们通过 [Discussions](https://github.com/TJ-CSCCG/TongjiThesis/discussions) 提供技术支持，详见[此帖](https://github.com/TJ-CSCCG/TongjiThesis/discussions/6)。

**请勿通过即时通讯工具直接联系贡献者。**

### 反馈 Bug | Reporting a Bug

如确认存在 Bug，请通过 [Issue](https://github.com/TJ-CSCCG/TongjiThesis/issues) 模板提交反馈。

### 提交 Pull Request

1. Fork 本仓库。
2. 将 Fork 后的仓库克隆到本地。
3. 基于 `dev` 分支创建一个新分支进行修改（**不要**基于 `master`：`master` 仅在发布时由 `dev` 快进合并而来，不接受直接 PR）。
4. 提交更改到新分支。
5. 将分支推送到你的 Fork 仓库。
6. 从你的分支向本仓库发起 Pull Request，**并将 base 分支手动改为 `dev`**（GitHub 默认会建议 `master`，需手动切换）。

## 项目历史

| 日期    | 贡献者                                            | 贡献内容                                                                                                                                                                                                 |
| ------- | ------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 2019.05 | [YukuanHU](https://github.com/YukuanHu)           | 项目起源，上传本科毕业设计论文                                                                                                                                                                           |
| 2021.05 | [ganler](https://github.com/ganler)               | 增强功能（项目结构与平台适配），开始维护新项目                                                                                                                                                           |
| 2022.05 | [skyleaworlder](https://github.com/skyleaworlder) | 开始贡献，整合进 [TJ-CSCCG](https://github.com/TJ-CSCCG)，持续更新改进                                                                                                                                   |
| 2023.04 | [RizhongLin](https://github.com/RizhongLin)       | 开始贡献，负责项目维护和更新                                                                                                                                                                             |
| 2025.04 | —                                                 | 实现基于键值对的类选项，支持更灵活的配置                                                                                                                                                                 |
| 2026    | —                                                 | 迁移至 `ctexbook` 基类，全面对齐 2026 版撰写规范；新增 `biblatex`/`bibtex` 双后端、理工/文科双编号体系（`field`）、信息说明页（`\MakeInfoPage`）、跨页代码环境（`longlisting`）；参考文献样式升级至 GB/T 7714-2025（新增 `@preprint` 预印本类型示例）；CI 升级至 TeX Live 2026；新增 `doctype` 选项与任务书/开题报告/中期报告 3 个独立文档（`taskbook.tex`/`proposal.tex`/`midterm.tex`），任务书起讫周数自动换算 |

我们非常感谢以上贡献者的付出。如果您觉得本项目对您的毕业设计或论文有所帮助，希望您可以在致谢部分提及。

## 版本发布

- 提交信息遵循 [Conventional Commits](https://www.conventionalcommits.org/)（`feat:` / `fix:` / `docs:` 等）；[release-please](https://github.com/googleapis/release-please) 据此自动维护版本号与逐版本更新日志 `CHANGELOG.md`（首次自动发布后生成）。
- 发布流程：维护者合并 release-please 生成的「release PR」→ 自动创建带更新日志的**草稿 Release** → 核对后手动 **Publish**，随即触发 CI 打包 CTAN 与示例 PDF 并附加到该 Release。
- 版本号由 release-please 统一更新（`package.json` 及各 `\Provides*` 行），**无需手动修改**（原 `scripts/bump-version.sh` 已移除）。
