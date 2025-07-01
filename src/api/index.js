import request from "./request"; // 引入预配置的axios实例

const api = {
    fetchTeachers(page, size, type, condition) {
        return request.get("/api/admin/teacher", {
            params: { page, size, type, condition },
        });
    },

    fetchStudent(page, size, type, condition) {
        return request.get("/api/admin/student", {
            params: { page, size, type, condition },
        });
    },

    fetchMajors(page, size, type, condition) {
        return request.get("/api/admin/major", {
            params: { page, size, type, condition },
        });
    },

    fetchClass(page, size, type, condition) {
        return request.get("/api/admin/class", {
            params: { page, size, type, condition },
        });
    },

    fetchCourse(page, size, type, condition) {
        return request.get("/api/admin/course", {
            params: { page, size, type, condition },
        });
    },

    fetchCourseset(page, size, type, condition) {
        return request.get("/api/admin/course_schedule", {
            params: { page, size, type, condition },
        });
    },

    addCourseset(formData) {
        return request.post("/api/admin/course_schedule", formData);
    },

    updateCourseset(formData) {
        return request.put("/api/admin/course_schedule", formData);
    },

    deleteCourseset(formData) {
        return request.post("/api/admin/course_schedule/delete", formData);
    },

    fetchDepartment(page, size, type, condition) {
        return request.get("/api/admin/college", {
            params: { page, size, type, condition },
        });
    },

    fetchTeachersFind(page, size, name, gender, college, jobTitle) {
        return request.get("/api/admin/teacher/find", {
            params: { page, size, name, gender, college, jobTitle },
        });
    },

    fetchStudentsFind(page, size, name, gender, className, hometown) {
        return request.get("/api/admin/student/find", {
            params: { page, size, name, gender, className, hometown },
        });
    },

    fetchScore(page, size, term, type, condition) {
        return request.get("/api/admin/score", {
            params: { page, size, term, type, condition },
        });
    },

    fetchAVGScore(page, size, type, condition) {
        return request.get("/api/admin/score/ave", {
            params: { page, size, type, condition },
        });
    },

    fetchScoreAllYear(year, type, condition) {
        return request.get("/api/admin/score/all_year", {
            params: { year, type, condition },
        });
    },

    deleteTeacher(id) {
        return request.delete("/api/admin/teacher", {
            params: { id },
        });
    },

    deleteMajor(id) {
        return request.delete("/api/admin/major", {
            params: { id },
        });
    },

    updateClass(id, name, major, teacherId) {
        return request.post("/api/admin/class", {
            id: id,
            name: name,
            major: major,
            teacherId: teacherId,
        });
    },

    deleteClass(id) {
        return request.put("/api/admin/class", {
            params: { id },
        });
    },

    addClass(id, name, major, teacherId) {
        return request.post("/api/admin/class", {
            id: id,
            name: name,
            major: major,
            teacherId: teacherId,
        });
    },

    deleteCourse(id) {
        return request.delete("/api/admin/course", {
            params: { id },
        });
    },

    deleteStudent(id) {
        return request.delete("/api/admin/student", {
            params: { id },
        });
    },
    deleteDepartment(id) {
        return request.delete("/api/admin/college", {
            params: { id },
        });
    },

    resetTeacherPassword(id) {
        return request.put("/api/admin/teacher/password", {
            id: Number(id),
        });
    },

    resetStudentPassword(id) {
        return request.put("/api/admin/student/password", {
            id: Number(id),
        });
    },

    hometownCount() {
        return request.get("/api/admin/student/hometown_count");
    },

    getHometownStudent(page, size, hometown) {
        return request.get("/api/admin/student/hometown", {
            params: { page, size, hometown },
        });
    },

    adminChangePassword(oldPassword, newPassword) {
        return request.put("/api/admin/password", {
            oldPassword: oldPassword,
            newPassword: newPassword,
        });
    },

    adminChangePasswordWithoutLogin(account, newPassword) {
        return request.put("/api/admin/passwordWithoutLogin", {
            account: account,
            newPassword: newPassword,
        });
    },

    studentGetScore(page, size, term) {
        return request.get("/api/student/score", {
            params: { page, size, term },
        });
    },

    studentGetAllScore(page, size, term) {
        return request.get("/api/student/all_score", {
            params: { page, size, term },
        });
    },

    studentGetCourse(page, size, term) {
        return request.get("/api/student/course", {
            params: { page, size, term },
        });
    },

    studentChangePassword(oldPassword, newPassword) {
        return request.put("/api/student/password", {
            oldPassword: oldPassword,
            newPassword: newPassword,
        });
    },

    studentChangePasswordWithoutLogin(account, newPassword) {
        return request.put("/api/student/passwordWithoutLogin", {
            account: account,
            newPassword: newPassword,
        });
    },

    studentGetClassTable(page, size, term) {
        return request.get("/api/student/class_table", {
            params: { page, size, term },
        });
    },

    teacherChangePassword(oldPassword, newPassword) {
        return request.put("/api/teacher/password", {
            oldPassword: oldPassword,
            newPassword: newPassword,
        });
    },

    teacherChangePasswordWithoutLogin(account, newPassword) {
        return request.put("/api/teacher/passwordWithoutLogin", {
            account: account,
            oldPassword: oldPassword,
            newPassword: newPassword,
        });
    },

    teacherClassTable(page, size, term) {
        return request.get("/api/teacher/class_table", {
            params: { page, size, term },
        });
    },

    teacherGetScore(page, size, course_id, class_name) {
        return request.get("/api/teacher/score", {
            params: { page, size, course_id, class_name },
        });
    },

    teacherPostScore(student_id, course_id, score, term) {
        return request.post("/api/teacher/score", null, {
            params: {
                student_id: student_id,
                course_id: course_id,
                score: score,
                term: term,
            },
        });
    },

    teacherAvgScore(page, size) {
        return request.get("/api/teacher/ave_score", {
            params: { page, size },
        });
    },

    addAdmin(id, password) {
        return request.post("/api/admin", {
            id: id,
            password: password,
            role: "SUPER_ADMIN",
        });
    },
    fetchExamCourses() {
        return request.get("/api/admin/exams");
    },
    fetchStudentExamCourses() {
        return request.get("/api/student/exams_stu");
    },
    fetchStudentInfo() {
        return request.get("/api/student/stu_info");
    },

    fetchTeacherExamCourses() {
        return request.get("/api/teacher/exams_teacher");
    },

    fetchTeacherInfo() {
        return request.get("/api/teacher/teacher_info");
    },

    fetchSchoolInfo() {
        return request.get("/api/admin/schoolInfo");
    },
};

export default api;
