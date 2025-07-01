# ? 学生成绩管理系统

<div align="center">

![Vue.js](https://img.shields.io/badge/Vue.js-3.x-4FC08D?style=for-the-badge&logo=vue.js&logoColor=white)
![Element Plus](https://img.shields.io/badge/Element%20Plus-2.x-409EFF?style=for-the-badge&logo=element&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-16+-339933?style=for-the-badge&logo=node.js&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-13+-336791?style=for-the-badge&logo=postgresql&logoColor=white)

**基于 Vue.js + Element Plus + PostgreSQL 的现代化学生成绩管理系统**

[在线演示](#) | [项目文档](#) | [问题反馈](#)

</div>

---

## ? 目录

- [项目简介](#-项目简介)
- [功能特性](#-功能特性)
- [技术栈](#-技术栈)
- [系统架构](#-系统架构)
- [快速开始](#-快速开始)
- [项目结构](#-项目结构)
- [功能模块](#-功能模块)
- [数据库设计](#-数据库设计)
- [API 接口](#-api-接口)
- [部署指南](#-部署指南)
- [贡献指南](#-贡献指南)
- [许可证](#-许可证)

---

## ? 项目简介

学生成绩管理系统是一个基于 Vue.js 3 和 Element Plus 开发的现代化 Web 应用，旨在为高校提供完整的学生信息管理解决方案。系统支持管理员、教师和学生三种角色，提供成绩录入、查询、统计分析等核心功能。

### ? 核心优势

- **? 现代化界面**：采用 Element Plus 设计语言，界面美观、交互友好
- **? 响应式设计**：完美适配桌面端和移动端
- **? 权限管理**：基于角色的访问控制，确保数据安全
- **? 数据可视化**：丰富的图表展示，直观呈现数据趋势
- **? 高性能**：优化的数据库设计和前端性能

---

## ? 功能特性

### ??? 管理员功能
- **用户管理**：学生、教师信息的增删改查
- **课程管理**：课程信息维护、课程安排
- **班级管理**：班级信息管理、学生分班
- **成绩统计**：成绩分析、排名统计
- **系统设置**：学院、专业信息管理

### ??? 教师功能
- **成绩录入**：批量录入、修改学生成绩
- **成绩查询**：查看所教课程的学生成绩
- **成绩分析**：课程平均分、及格率统计
- **课程管理**：查看教学课程安排

### ??? 学生功能
- **成绩查询**：查看个人成绩、学分统计
- **课程查询**：查看选课信息、课程安排
- **成绩分析**：个人成绩趋势分析
- **考试日历**：查看考试时间安排

### ? 系统功能
- **用户认证**：登录、注销、密码修改
- **忘记密码**：通过安全问题重置密码
- **数据导出**：成绩数据 Excel 导出
- **实时通知**：重要信息实时推送

---

## ? 技术栈

### 前端技术
- **Vue.js 3** - 渐进式 JavaScript 框架
- **Element Plus** - Vue 3 组件库
- **Vue Router** - 官方路由管理器
- **Axios** - HTTP 客户端
- **ECharts** - 数据可视化图表库

### 后端技术
- **Spring Boot** - Java 应用框架
- **PostgreSQL** - 关系型数据库
- **MyBatis** - 数据持久层框架
- **JWT** - 身份认证

### 开发工具
- **Node.js** - JavaScript 运行时
- **npm** - 包管理器
- **Vue CLI** - Vue.js 开发工具
- **Git** - 版本控制

---

## ? 系统架构

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   前端层        │    │   后端层        │    │   数据层        │
│                 │    │                 │    │                 │
│  Vue.js 3       │?──?│  Spring Boot    │?──?│  PostgreSQL     │
│  Element Plus   │    │  MyBatis        │    │                 │
│  Vue Router     │    │  JWT Auth       │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

---

## ? 快速开始

### 环境要求

- Node.js >= 16.0.0
- npm >= 8.0.0
- PostgreSQL >= 13.0

### 安装步骤

1. **克隆项目**
```bash
git clone https://github.com/your-username/student-management-system.git
cd student-management-system
```

2. **安装依赖**
```bash
npm install
```

3. **配置环境变量**
```bash
# 复制环境变量文件
cp .env.example .env

# 编辑环境变量
vim .env
```

4. **启动开发服务器**
```bash
npm run serve
```

5. **访问应用**
打开浏览器访问 `http://localhost:8080`

### 构建生产版本

```bash
# 构建生产版本
npm run build

# 预览生产版本
npm run preview
```

---

## ? 项目结构

```
src/
├── api/                 # API 接口
│   ├── index.js        # API 统一导出
│   ├── request.js      # Axios 配置
│   └── path.js         # API 路径配置
├── assets/             # 静态资源
│   ├── img/           # 图片资源
│   └── styles/        # 样式文件
├── components/         # 公共组件
│   ├── Navigation.vue # 导航组件
│   └── ...
├── router/            # 路由配置
│   └── index.js      # 路由主文件
├── views/             # 页面组件
│   ├── admin/        # 管理员页面
│   ├── teacher/      # 教师页面
│   ├── student/      # 学生页面
│   └── common/       # 公共页面
├── App.vue           # 根组件
└── main.js          # 入口文件
```

---

## ? 功能模块

### 用户管理模块
- 用户注册、登录、注销
- 角色权限管理
- 密码重置功能

### 成绩管理模块
- 成绩录入与修改
- 成绩查询与统计
- 成绩分析报告

### 课程管理模块
- 课程信息维护
- 课程安排管理
- 选课信息查询

### 班级管理模块
- 班级信息管理
- 学生分班管理
- 班级统计信息

### 系统管理模块
- 学院专业管理
- 系统参数配置
- 数据备份恢复

---

## ? 数据库设计

### 核心表结构

| 表名 | 描述 | 主要字段 |
|------|------|----------|
| `chenwk_admin03` | 管理员表 | ID、密码、角色 |
| `chenwk_student03` | 学生表 | ID、姓名、班级、学分 |
| `chenwk_teacher03` | 教师表 | ID、姓名、学院、职称 |
| `chenwk_course03` | 课程表 | ID、名称、学分、学期 |
| `chenwk_score03` | 成绩表 | 学生ID、课程ID、成绩 |
| `chenwk_class03` | 班级表 | ID、名称、专业、人数 |

### 触发器设计

系统包含 5 个核心触发器：

1. **学生人数管理触发器**：自动维护班级学生人数
2. **成绩记录生成触发器**：课程安排时自动生成成绩记录
3. **成绩记录删除触发器**：课程取消时级联删除成绩记录
4. **学分更新触发器**：成绩变更时自动计算学分
5. **重修标记触发器**：不及格时自动标记重修状态

---

## ? API 接口

### 认证接口
```
POST /api/admin/login      # 管理员登录
POST /api/teacher/login    # 教师登录
POST /api/student/login    # 学生登录
PUT  /api/*/password       # 修改密码
```

### 成绩管理接口
```
GET  /api/admin/score      # 成绩查询
POST /api/teacher/score    # 成绩录入
PUT  /api/teacher/score    # 成绩修改
GET  /api/student/score    # 学生成绩查询
```

### 用户管理接口
```
GET  /api/admin/student    # 学生列表
POST /api/admin/student    # 添加学生
PUT  /api/admin/student    # 修改学生
DELETE /api/admin/student  # 删除学生
```

---

## ? 部署指南

### Docker 部署

1. **构建镜像**
```bash
docker build -t student-management-system .
```

2. **运行容器**
```bash
docker run -d -p 80:80 student-management-system
```

### 传统部署

1. **构建项目**
```bash
npm run build
```

2. **配置 Nginx**
```nginx
server {
    listen 80;
    server_name your-domain.com;
    
    location / {
        root /path/to/dist;
        try_files $uri $uri/ /index.html;
    }
}
```

3. **启动服务**
```bash
# 使用 PM2 管理进程
pm2 start npm --name "student-management" -- run serve
```

---

## ? 贡献指南

我们欢迎所有形式的贡献！

### 贡献方式

1. **Fork 项目**
2. **创建功能分支** (`git checkout -b feature/AmazingFeature`)
3. **提交更改** (`git commit -m 'Add some AmazingFeature'`)
4. **推送到分支** (`git push origin feature/AmazingFeature`)
5. **创建 Pull Request**

### 开发规范

- 遵循 Vue.js 官方风格指南
- 使用 ESLint 进行代码检查
- 编写单元测试
- 更新相关文档

---

## ? 许可证

本项目采用 [MIT 许可证](LICENSE) - 查看 [LICENSE](LICENSE) 文件了解详情。

---

## ? 联系我们

- **项目维护者**：cwk
- **邮箱**：your-email@example.com
- **项目地址**：https://github.com/Beatrice-kk/Database_Work_Front.git
---

<div align="center">

**如果这个项目对你有帮助，请给它一个 ??**


</div>
