# Agent 工作台

本仓库为多 Agent 协作工作台。所有 Agent 共用同一套 Git 仓库和规则体系，通过 `AGENTS.md` 实现规则复用与隔离。

## 多 Agent 如何复用 AGENTS.md

### 机制

```
入口文件（元规则：强制 AGENTS.md 优先）
       │
       ▼
根 AGENTS.md（全局规则 + Agent 索引）
       │
       ├──▶ <workspace-1>/AGENTS.md  ← Agent 1 专属规则
       ├──▶ <workspace-2>/AGENTS.md  ← Agent 2 专属规则
       └──▶ ...
```

**工作流程：**
1. Agent 始终以仓库根目录为工作目录
2. 启动时，自动加载根目录入口文件（元规则）
3. 元规则要求：操作任何子目录前，必须先完整读取该子目录的 `AGENTS.md`
4. 子目录 `AGENTS.md` 中的指令与入口文件同等效力，Agent 必须无条件遵守

**复用方式：**
- **全局规则**（跨设备兼容、Knowledge 操作等）写在根 `AGENTS.md`，所有 Agent 共享
- **专属规则**（工具链、远程操作等）写在各子目录 `AGENTS.md`，仅对操作该目录的 Agent 生效
- Agent 可以同时持有全局规则和所在子目录的专属规则，互不冲突

### 多 Agent 同时工作

| 方式 | 操作 | 适合场景 |
|------|------|----------|
| 多会话 | 不同终端各自在根目录启动 Agent，操作不同子目录 | 日常并行工作 |
| git worktree | 为每个 Agent 创建独立 worktree | 需要同时修改同一文件、长期并行任务 |

无论哪种方式，所有 Agent 都遵循相同的规则加载路径。

---

## 全局规则

### 规则书写约定

- **禁止在 `AGENTS.md` 中提及任何特定 Agent 实现**（如 Claude、Copilot、Gemini 等）。规则必须面向所有 Agent，使用通用表述。
- 如需引用项目中的具体文件名（如 `CLAUDE.md`），仅作为路径引用，不得以此代指特定 Agent。

### AGENTS.md 优先

- **AGENTS.md 是唯一的规则文件**。所有项目规则、Agent 专属指令、工作流约定的读写操作，必须以 `AGENTS.md` 为目标。**禁止**将规则写入入口文件或任何其他文件。
- **先读后做**。操作任何子目录之前，**必须**先完整读取该目录的 `AGENTS.md`。未读取不得操作。
- 根目录只做索引，不存放具体规则。

### 临时目录

- 所有临时文件、中间产物、检出（clone）的外部仓库，**必须**放入 `tmp/` 目录。
- `tmp/` 已被 `.gitignore` 排除，不会纳入版本控制。
- 检出的外部仓库需删除 `.git` 后放入 `tmp/` 对应子目录，避免嵌套 Git 仓库冲突。

### 跨设备兼容

- **禁止**在任何代码、脚本、配置中硬编码绝对路径（如 `/c/Qun/ABC/...`、`C:\Qun\...`）
- 使用相对路径、环境变量或可配置变量代替
- 引用 Obsidian vault 时，优先用 vault 名称（`obsidian vault="xxx"`），而非文件系统路径
- Knowledge vault 的路径映射应集中在单一配置文件中，其余位置通过变量引用

### 网络访问

- 访问网络出现连接失败、超时或明显受限时，先尝试使用本机 `127.0.0.1:10808` 代理后再继续排查。

### Knowledge 知识库操作

以下 Obsidian vault 属于 Knowledge 知识库（路径随设备不同而变化）：

| Vault 名称 | 用途 |
|-----------|------|
| `Obsidian Vault` | 主知识库 |
| `Resouce Vault` | 资源库 |

操作这些 vault 时的优先级：

1. **首选 `obsidian` CLI** — 通过 `obsidian vault="名称"` 读写笔记、搜索、管理属性等
2. **降级方案** — `obsidian` CLI 无法满足时，才使用原生 shell；路径从 `obsidian` CLI 动态获取，不硬编码

> `obsidian` CLI 需要 Obsidian 桌面端运行并开启 CLI 功能。

### 语言

对话和文档使用中文。

### 快捷指令

用户说「提交」→ `git add -A` → `git commit -m "<自动生成消息>"` → `git push`

---

## Agent 索引

| Agent | 子目录 | 规则文件 | 职责 |
|-------|--------|----------|------|
| <!-- 在此添加 Agent --> | | | |

---

## 目录结构

```
<repo>/                       # 仓库根目录
├── AGENTS.md                 # 本文件：全局规则 + Agent 索引
├── .gitignore                # 全局忽略策略
│
├── <workspace-1>/            # Agent 工作区
│   └── AGENTS.md             # 专属规则
├── <workspace-2>/            # Agent 工作区
│   └── AGENTS.md             # 专属规则
└── tmp/                      # 临时目录（gitignored）：临时文件、检出外部仓库等
```

## 版本控制

- 各 Agent 工作区统一纳入根目录 Git 仓库管理
- 各 Agent 的构建产物（node_modules、.env、编译输出、缓存等）统一在根 `.gitignore` 中排除
- Agent 工作区相互独立，禁止跨工作区引用代码或配置
- 提交前，如需同步更新记录文档，只保留最终实际有效的内容；删除试错、回退、临时方案等过程性描述，确保记录简要且完整
