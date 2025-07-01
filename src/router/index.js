import { createRouter, createWebHashHistory } from "vue-router";

import Login from "@/views/LoginView.vue";
import AdminHome from "@/views/AdminHomeView.vue";
import StudentHome from "@/views/StudentHomeView.vue";
import TeacherHome from "@/views/TeacherHomeView.vue";
import ManageTeacher from "@/views/ManageTeacher.vue";
import ManageStudent from "@/views/ManageStudent.vue";
import ManageClass from "@/views/ManageClass.vue";
import ManageDepartment from "@/views/ManageDepartment.vue";
import ManageMajor from "@/views/ManageMajor.vue";
import ManageCourse from "@/views/ManageCourse.vue";
import ManageCourseSet from "@/views/ManageCourseSet.vue";
import ScoreSearch from "@/views/ScoreSearch.vue";
import AvgScoreSearch from "@/views/AvgScoreSearch.vue";
import Hometowm from "@/views/Hometowm.vue";
import ScoreRank from "@/views/ScoreRank.vue";
import StuScore from "@/views/StuScore.vue";
import StuScoreYear from "@/views/StuScoreYear.vue";
import StuSearchClass from "@/views/StuSearchClass.vue";
import StuReadClass from "@/views/StuReadClass.vue";
import TeacherAddScore from "@/views/TeacherAddScore.vue";
import TeacherAvgScore from "@/views/TeacherAvgScore.vue";
import TeacherSearchClass from "@/views/TeacherSearchClass.vue";

const routes = [
    { path: "/", component: Login },
    { path: "/admin/home", component: AdminHome },
    { path: "/student/home", component: StudentHome },
    { path: "/teacher/home", component: TeacherHome },
    { path: "/admin/student-management", component: ManageStudent },
    { path: "/admin/teacher-management", component: ManageTeacher },
    { path: "/admin/class-management", component: ManageClass },
    { path: "/admin/major-management", component: ManageMajor },
    { path: "/admin/course-management", component: ManageCourse },
    { path: "/admin/courseset-management", component: ManageCourseSet },
    { path: "/admin/department-management", component: ManageDepartment },
    { path: "/admin/scoresearch", component: ScoreSearch },
    { path: "/admin/avgscoresearch", component: AvgScoreSearch },
    { path: "/admin/hometowm", component: Hometowm },
    { path: "/admin/scorerank", component: ScoreRank },
    { path: "/student/stuscore", component: StuScore },
    { path: "/student/stuscoreyear", component: StuScoreYear },
    { path: "/student/stusearchclass", component: StuSearchClass },
    { path: "/student/stureadclass", component: StuReadClass },
    { path: "/teacher/teacheraddscore", component: TeacherAddScore },
    { path: "/teacher/teacheravgscore", component: TeacherAvgScore },
    { path: "/teacher/teachersearchclass", component: TeacherSearchClass },
];

const router = createRouter({
    history: createWebHashHistory(),
    routes,
});
router.beforeEach((to, from, next) => {
    if (to.path == "/") {
        next();
    } else {
        // 获取 token
        const token = sessionStorage.getItem("Authorization");
        // token 不存在
        if (token === null || token === "") {
            // next();
            alert("请先登录");
            next("/");
        } else {
            next();
        }
    }
});
export default router;
