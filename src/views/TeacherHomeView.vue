<template>
    <NavigationTea>
        <div class="home-view">
            <el-row>
                <el-col :span="24">
                    <h2>
                        欢迎您进入学生信息管理系统
                        <el-text class="greeting-text">
                            {{ greeting }}，{{ teacher_info.name }}老师</el-text
                        >
                    </h2>
                    <el-text class="large-text">{{ input }}</el-text>
                </el-col>
            </el-row>
        </div>

        <div class="main-container">
            <!-- 左侧：日历区域 -->
            <div class="calendar-section">
                <el-card class="calendar-card">
                    <template #header>
                        <div class="card-header">
                            <span>📅 系统日历</span>
                        </div>
                    </template>
                    <div class="calendar-content">
                        <el-calendar v-model="value">
                            <template #dateCell="{ data }">
                                <div class="calendar-cell">
                                    <span class="calendar-day">{{
                                        data.day.split("-").slice(2).join("")
                                    }}</span>
                                    <div
                                        v-if="hasExamOnDate(data.day)"
                                        class="exam-marker"
                                    >
                                        <el-tooltip
                                            :content="
                                                getExamInfoForDate(data.day)
                                            "
                                            placement="top"
                                        >
                                            <div class="exam-dot"></div>
                                        </el-tooltip>
                                    </div>
                                </div>
                            </template>
                        </el-calendar>
                    </div>
                </el-card>
            </div>

            <!-- 中间：考试信息，优化为上下卡片放在一个竖直卡片中 -->
            <div class="exam-section">
                <el-card class="main-card" style="padding: 10px">
                    <template #header>
                        <div class="card-header" style="margin-top: 5px">
                            <span>📚 我的考试与操作</span>
                        </div>
                    </template>

                    <!-- 子卡片一：开设课程 -->
                    <el-card
                        class="exam-info-card"
                        shadow="never"
                        style="margin-bottom: 20px; height: 230px"
                    >
                        <template #header>
                            <div
                                class="card-header"
                                style="margin-top: 5px; height: 10px"
                            >
                                <span>📘 开设课程</span>
                            </div>
                        </template>
                        <div class="exam-content" style="">
                            <div v-if="allexam.length > 0" class="exam-list">
                                <div
                                    v-for="(exam, index) in allexam"
                                    :key="index"
                                    class="exam-item"
                                >
                                    <div class="exam-course">
                                        课程: {{ exam.name }}
                                    </div>
                                    <div class="exam-time">
                                        考试时间:
                                        {{ formatExamDate(exam.examDate) }}
                                    </div>
                                    <div
                                        class="exam-location"
                                        v-if="exam.location"
                                    >
                                        地点: {{ exam.location }}
                                    </div>
                                    <el-divider
                                        v-if="index < allexam.length - 1"
                                    />
                                </div>
                            </div>
                            <div v-else class="no-exam">暂无考试信息</div>
                        </div>
                    </el-card>

                    <!-- 子卡片二：快捷操作 -->
                    <el-card
                        class="action-card"
                        shadow="never"
                        style="height: 200px"
                    >
                        <template #header>
                            <div class="card-header">
                                <span>⚙️ 快捷操作</span>
                            </div>
                        </template>
                        <div class="action-content">
                            <div
                                class="action-buttons"
                                style="margin-top: -20px; margin-left: -10px"
                            >
                                <el-button
                                    style="margin-left: 10px; margin-top: 5px"
                                    type="primary"
                                    @click="
                                        clear_data();
                                        dialogVisible = true;
                                    "
                                    class="action-btn"
                                >
                                    <span class="btn-icon">🔒</span>
                                    <span class="btn-text">修改密码</span>
                                </el-button>
                            </div>
                        </div>
                    </el-card>
                </el-card>
            </div>

            <!-- 右侧：快捷操作 -->
            <div class="action-section">
                <!-- 教师信息卡片 -->
                <el-card class="profile-card">
                    <template #header>
                        <div class="card-header">
                            <span>👨‍🏫 教师信息</span>
                        </div>
                    </template>
                    <div class="profile-content">
                        <el-descriptions
                            :column="2"
                            border
                            class="profile-info"
                            size="default"
                        >
                            <el-descriptions-item label="姓名">
                                {{ teacher_info.name }}
                            </el-descriptions-item>
                            <el-descriptions-item label="工号">
                                {{ teacher_info.id }}
                            </el-descriptions-item>
                            <el-descriptions-item label="性别">
                                {{ teacher_info.gender }}
                            </el-descriptions-item>
                            <el-descriptions-item label="年龄">
                                {{
                                    new Date().getFullYear() -
                                    teacher_info.birthYear
                                }}
                            </el-descriptions-item>

                            <el-descriptions-item label="职称">
                                {{ teacher_info.jobTitle }}
                            </el-descriptions-item>
                            <el-descriptions-item label="学院">
                                {{ teacher_info.college }}
                            </el-descriptions-item>
                            <el-descriptions-item label="联系方式">
                                {{ teacher_info.phone }}
                            </el-descriptions-item>
                        </el-descriptions>
                    </div>
                </el-card>
            </div>
        </div>

        <!-- 修改密码对话框 -->
        <el-dialog
            title="修改密码"
            v-model="dialogVisible"
            width="400px"
            class="styled-dialog"
        >
            <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                <el-form-item label="旧密码" prop="oldpass">
                    <el-input
                        v-model="form.oldpass"
                        show-password
                        placeholder="请输入旧密码"
                    ></el-input>
                </el-form-item>
                <el-form-item label="新密码" prop="newpass">
                    <el-input
                        v-model="form.newpass"
                        show-password
                        placeholder="请输入新密码"
                    ></el-input>
                </el-form-item>
            </el-form>
            <template #footer>
                <el-button @click="clear_data()">取消</el-button>
                <el-button
                    type="primary"
                    @click="
                        changepassword();
                        clear_data();
                    "
                >
                    确定
                </el-button>
            </template>
        </el-dialog>
    </NavigationTea>
</template>

<script>
import NavigationTea from "../components/NavigationTea.vue";
import api from "@/api/index.js";
// import * as echarts from "echarts";
export default {
    computed: {
        currentYear() {
            return new Date().getFullYear();
        },
    },
    name: "AdminHomeView",
    components: {
        NavigationTea,
    },
    // 在data()函数中添加
    data() {
        return {
            greeting: "",

            allexam: [],
            teacher_info: [],
            user_id: "",
            dialogVisible: false,
            input: " ",
            myChart: {},
            myChartStyle: { float: "left", width: "100%", height: "400px" },
            form: {
                oldpass: "",
                newpass: "",
            },
            rules: {
                old_pass: [
                    {
                        required: true,
                        message: "请输入旧密码",
                        trigger: "blur",
                    },
                ],
                new_pass: [
                    {
                        required: true,
                        message: "请输入新密码",
                        trigger: "blur",
                    },
                ],
            },
            value: new Date(),
            examList: [],
        };
    },
    // 在methods中添加新方法
    methods: {
        formatExamDate(datetimeStr) {
            if (!datetimeStr) return "";
            return datetimeStr.replace("T", " ");
        },
        clear_data() {
            this.form.oldpass = "";
            this.form.newpass = "";
            this.dialogVisible = false;
        },
        async changepassword() {
            try {
                const response = await api.teacherChangePassword(
                    this.form.oldpass,
                    this.form.newpass
                );
                if (response.data.code === 200) {
                    this.$message.success("密码修改成功");
                } else {
                    this.$message.error("密码修改失败");
                }
            } catch (error) {
                console.error("请求失败", error);
                this.$message.error("请求过程中发生错误");
            }
        },
        async fetchExamDates() {
            try {
                // 尝试从后端获取考试日期数据
                const response = await api.getTeacherExamDates();
                if (response && response.data && response.data.code === 200) {
                    this.examList = response.data.data;
                } else {
                    // 如果后端接口未实现或返回错误，使用模拟数据
                    console.warn("使用模拟考试数据");
                    this.examList = [
                        {
                            date: "2023-06-15",
                            courseName: "数据库原理",
                            location: "教学楼101",
                        },
                        {
                            date: "2023-06-20",
                            courseName: "操作系统",
                            location: "教学楼202",
                        },
                        {
                            date: "2023-06-25",
                            courseName: "计算机网络",
                            location: "教学楼303",
                        },
                    ];
                }
            } catch (error) {
                console.error("获取考试日期失败", error);
                // 发生错误时使用模拟数据
                this.examList = [
                    {
                        date: "2023-06-15",
                        courseName: "数据库原理",
                        location: "教学楼101",
                    },
                    {
                        date: "2023-06-20",
                        courseName: "操作系统",
                        location: "教学楼202",
                    },
                    {
                        date: "2023-06-25",
                        courseName: "计算机网络",
                        location: "教学楼303",
                    },
                ];
            }
        },

        async fetchTeacherExamCourses() {
            try {
                const response = await api.fetchTeacherExamCourses();
                console.log(response); // 检查返回结构

                if (response.data.code === 200) {
                    // 按照考试时间升序排序
                    const sortedData = response.data.data.sort(
                        (a, b) => new Date(a.examDate) - new Date(b.examDate)
                    );
                    this.allexam = sortedData;
                    console.log("考试信息加载成功", this.allexam);
                } else {
                    this.$message.error("加载考试信息失败！");
                }
            } catch (err) {
                console.error("API 调用失败", err);
                this.$message.error("ERROR！");
            }
        },
        async fetchTeacherInfo() {
            try {
                const res = await api.fetchTeacherInfo();
                console.log("教师信息返回：", res);

                if (res.data && res.data.code === 200) {
                    this.teacher_info = res.data.data;
                } else {
                    this.$message.error("教师信息加载失败！");
                }
            } catch (error) {
                console.error("请求教师信息失败：", error);
                this.$message.error("ERROR！");
            }
        },

        hasExam(day) {
            return this.examList.some((exam) => exam.date === day);
        },
        getExamInfo(day) {
            const exam = this.examList.find((exam) => exam.date === day);
            return exam ? `${exam.courseName} (${exam.location})` : "";
        },
        hasExamOnDate(date) {
            // 检查allexam中是否有考试在指定日期
            return this.allexam.some((exam) => {
                if (!exam.examDate) return false;
                const examDate = new Date(exam.examDate);
                const checkDate = new Date(date);
                return examDate.toDateString() === checkDate.toDateString();
            });
        },
        getExamInfoForDate(date) {
            // 获取指定日期的考试信息
            const exams = this.allexam.filter((exam) => {
                if (!exam.examDate) return false;
                const examDate = new Date(exam.examDate);
                const checkDate = new Date(date);
                return examDate.toDateString() === checkDate.toDateString();
            });

            if (exams.length === 0) return "";

            return exams
                .map((exam) => {
                    const time = new Date(exam.examDate).toLocaleTimeString(
                        "zh-CN",
                        {
                            hour: "2-digit",
                            minute: "2-digit",
                        }
                    );
                    return `${exam.name} (${time})`;
                })
                .join("\n");
        },
    },
    created() {
        this.fetchExamDates();
        const hour = new Date().getHours();
        if (hour < 12) {
            this.greeting = "早上好";
        } else if (hour < 18) {
            this.greeting = "下午好";
        } else {
            this.greeting = "晚上好";
        }
    },
    mounted() {
        this.fetchTeacherExamCourses();
        this.fetchTeacherInfo();
    },
};
</script>

<style scoped>
.greeting-text {
    font-size: 20px;
    font-weight: bold;
    color: #409eff;
    margin-top: 20px;
}
/* 页面整体布局 */
.home-view {
    max-width: 100%;
    margin: 30px auto 0;
    text-align: center;
    color: #a361dc;
}

.home-view h2 {
    width: 1000px;
    font-size: 32px;
    font-weight: 1000;
    color: #a361dc;
    margin-bottom: 15px;
    text-shadow: 0 2px 4px rgba(163, 97, 220, 0.1);
}

.large-text {
    font-size: 18px;
    color: #8b5cf6;
    margin: 15px 0;
    display: block;
    font-weight: 500;
}

.main-container {
    display: flex;
    justify-content: space-between;
    align-items: stretch;
    margin: 50px auto;
    max-width: 1400px;
    gap: 30px;
    padding: 0 20px;
    min-height: 600px; /* 确保容器有最小高度 */
}

/* 通用卡片样式 */
.calendar-section,
.exam-section,
.action-section {
    display: flex;
    flex-direction: column;
    height: 600px;
}

.calendar-section {
    flex: 2;
    min-width: 400px;
}

.exam-section {
    flex: 1.5;
    min-width: 350px;
}

.action-section {
    flex: 1;
    min-width: 280px;
}

.calendar-card,
.exam-info-card,
.action-card,
.profile-card,
.main-card {
    background: rgba(255, 255, 255, 0.95);
    border-radius: 16px;
    box-shadow: 0 8px 32px rgba(163, 97, 220, 0.1);
    border: 1px solid rgba(163, 97, 220, 0.1);
    backdrop-filter: blur(10px);
    height: 100%;
    display: flex;
    flex-direction: column;
}

/* 主卡片样式 */
.main-card {
    height: 100%;
    padding: 20px;
}

/* 子卡片样式 */
.main-card .el-card {
    border-radius: 12px;
    box-shadow: 0 4px 16px rgba(163, 97, 220, 0.08);
    border: 1px solid rgba(163, 97, 220, 0.08);
    margin-bottom: 20px;
}

.main-card .el-card:last-child {
    margin-bottom: 0;
}

/* 卡片内容区域 */
.calendar-content,
.exam-content,
.action-content,
.profile-content {
    flex: 1;
    display: flex;
    flex-direction: column;
    overflow: hidden;
}

.calendar-content {
    overflow: hidden;
    height: 420px;
}

.exam-content {
    overflow: hidden;
    height: 300px;
}

.action-content {
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 20px 0;
}

.profile-content {
    padding: 10px;
}

/* 卡片头部样式 */
.card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
    flex-shrink: 0; /* 防止头部被压缩 */
}

.card-header span {
    font-size: 20px;
    font-weight: 600;
    color: #a361dc;
}

/* 操作按钮样式 */
.action-buttons {
    display: flex;
    flex-direction: column;
    align-items: stretch;
    gap: 20px;
    width: 80%;
    padding-left: 10%;
}

.action-btn {
    height: 70px;
    width: 100%;
    font-size: 16px;
    font-weight: 600;
    color: white;
    border: none;
    border-radius: 12px;
    background: linear-gradient(135deg, #a361dc 0%, #8b5cf6 100%);
    box-shadow: 0 6px 20px rgba(163, 97, 220, 0.3);
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 12px;
    position: relative;
    overflow: hidden;
}

.action-btn::before {
    content: "";
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(
        90deg,
        transparent,
        rgba(255, 255, 255, 0.2),
        transparent
    );
    transition: left 0.5s;
}

.action-btn:hover::before {
    left: 100%;
}

.action-btn:hover {
    background: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%);
    transform: translateY(-3px);
    box-shadow: 0 10px 30px rgba(163, 97, 220, 0.4);
}

.action-btn:active {
    transform: translateY(-1px);
    box-shadow: 0 6px 20px rgba(163, 97, 220, 0.3);
}

.btn-icon {
    font-size: 24px;
    filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
}

.btn-text {
    font-size: 16px;
    font-weight: 600;
    letter-spacing: 0.5px;
}

/* 考试信息样式 */
.exam-list {
    flex: 1;
    overflow-y: auto;
    padding: 10px;
    max-height: 400px;
    scrollbar-width: thin;
    scrollbar-color: rgba(163, 97, 220, 0.3) transparent;
}

.exam-list::-webkit-scrollbar {
    width: 6px;
}

.exam-list::-webkit-scrollbar-track {
    background: rgba(163, 97, 220, 0.05);
    border-radius: 3px;
}

.exam-list::-webkit-scrollbar-thumb {
    background: rgba(163, 97, 220, 0.3);
    border-radius: 3px;
    transition: background 0.3s ease;
}

.exam-list::-webkit-scrollbar-thumb:hover {
    background: rgba(163, 97, 220, 0.5);
}

.exam-item {
    padding: 15px;
    margin-bottom: 10px;
    background: rgba(163, 97, 220, 0.05);
    border-radius: 12px;
    border: 1px solid rgba(163, 97, 220, 0.1);
    transition: all 0.3s ease;
}

.exam-item:hover {
    background: rgba(163, 97, 220, 0.1);
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(163, 97, 220, 0.2);
}

.exam-course {
    font-size: 16px;
    font-weight: 600;
    color: #a361dc;
    margin-bottom: 8px;
}

.exam-time,
.exam-location {
    font-size: 14px;
    color: #666;
    margin-bottom: 5px;
}

.no-exam {
    text-align: center;
    color: #999;
    padding: 40px 20px;
    font-size: 16px;
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* 个人信息样式 */
.profile-info {
    width: 100%;
}

:deep(.el-descriptions__header) {
    margin-bottom: 20px;
}

:deep(.el-descriptions__title) {
    color: #a361dc;
    font-weight: 600;
}

:deep(.el-descriptions__body) {
    background: rgba(163, 97, 220, 0.02);
}

:deep(.el-descriptions__label) {
    color: #a361dc;
    font-weight: 600;
    background: rgba(163, 97, 220, 0.05);
}

:deep(.el-descriptions__content) {
    color: #333;
}

/* Element UI 组件样式 */
:deep(.el-calendar) {
    background: transparent;
    flex: 1;
    display: flex;
    flex-direction: column;
}

:deep(.el-calendar__header) {
    background: linear-gradient(135deg, #a361dc 0%, #8b5cf6 100%);
    color: white;
    border-radius: 12px 12px 0 0;
    padding: 15px;
}

:deep(.el-calendar__title) {
    color: white;
    font-weight: 600;
}

:deep(.el-calendar__body) {
    padding: 20px;
    flex: 1;
}

:deep(.el-calendar-table) {
    height: 100%;
}

:deep(.el-calendar-table th) {
    background: rgba(163, 97, 220, 0.1);
    color: #a361dc;
    font-weight: 600;
    border: none;
}

:deep(.el-calendar-table td) {
    border: 1px solid rgba(163, 97, 220, 0.1);
    transition: all 0.3s ease;
}

:deep(.el-calendar-table td:hover) {
    background: rgba(163, 97, 220, 0.05);
}

:deep(.el-calendar-table .is-today) {
    background: linear-gradient(135deg, #a361dc 0%, #8b5cf6 100%);
    color: white;
    border-radius: 8px;
}

:deep(.el-dialog) {
    border-radius: 16px;
    box-shadow: 0 20px 60px rgba(163, 97, 220, 0.2);
    border: 1px solid rgba(163, 97, 220, 0.1);
}

:deep(.el-dialog__header) {
    background: linear-gradient(135deg, #a361dc 0%, #8b5cf6 100%);
    color: white;
    border-radius: 16px 16px 0 0;
    padding: 20px;
}

:deep(.el-dialog__title) {
    color: white;
    font-weight: 600;
}

:deep(.el-dialog__body) {
    padding: 30px;
}

:deep(.el-form-item__label) {
    color: #a361dc;
    font-weight: 600;
}

:deep(.el-input__wrapper) {
    background: rgba(163, 97, 220, 0.05);
    border: 2px solid rgba(163, 97, 220, 0.1);
    border-radius: 12px;
    transition: all 0.3s ease;
}

:deep(.el-input__wrapper:hover) {
    border-color: rgba(163, 97, 220, 0.3);
    box-shadow: 0 0 0 2px rgba(163, 97, 220, 0.1);
}

:deep(.el-input__wrapper.is-focus) {
    border-color: #a361dc;
    box-shadow: 0 0 0 2px rgba(163, 97, 220, 0.2);
}

:deep(.el-button) {
    border-radius: 12px;
    font-weight: 600;
    transition: all 0.3s ease;
}

:deep(.el-button--primary) {
    background: linear-gradient(135deg, #a361dc 0%, #8b5cf6 100%);
    border: none;
}

:deep(.el-button--primary:hover) {
    background: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%);
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(163, 97, 220, 0.4);
}

:deep(.el-divider) {
    border-color: rgba(163, 97, 220, 0.1);
    margin: 15px 0;
}

/* 日历单元格样式 */
.calendar-cell {
    position: relative;
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 60px;
}

.calendar-day {
    font-size: 14px;
    font-weight: 500;
    color: #333;
    margin-bottom: 4px;
}

/* 考试标记样式 */
.exam-marker {
    position: absolute;
    bottom: 4px;
    right: 4px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.exam-dot {
    width: 8px;
    height: 8px;
    background: linear-gradient(135deg, #a361dc 0%, #8b5cf6 100%);
    border-radius: 50%;
    box-shadow: 0 2px 4px rgba(163, 97, 220, 0.3);
    animation: pulse 2s infinite;
}

@keyframes pulse {
    0% {
        transform: scale(1);
        opacity: 1;
    }
    50% {
        transform: scale(1.2);
        opacity: 0.8;
    }
    100% {
        transform: scale(1);
        opacity: 1;
    }
}

/* 响应式设计 */
@media (max-width: 1200px) {
    .main-container {
        flex-direction: column;
        gap: 20px;
        padding: 0 10px;
    }

    .calendar-section,
    .exam-section,
    .action-section {
        width: 100%;
        height: auto;
        min-height: 400px;
    }

    .home-view h2 {
        width: auto;
        font-size: 24px;
    }
}

@media (max-width: 768px) {
    .home-view {
        padding: 20px;
        margin: 10px;
    }

    .home-view h2 {
        font-size: 20px;
    }

    .card-header span {
        font-size: 16px;
    }

    .action-buttons {
        width: 100%;
        padding-left: 0;
    }

    .exam-item {
        padding: 10px;
    }

    .exam-course {
        font-size: 14px;
    }

    .exam-time,
    .exam-location {
        font-size: 12px;
    }
}
</style>
