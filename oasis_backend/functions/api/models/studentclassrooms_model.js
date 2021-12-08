const database = require("../database");

// Here, we are implementing the class with Singleton design pattern

class StudentClassroomModel {
    constructor() {
        if (this.instance) return this.instance;
        StudentClassroomModel.instance = this;
    }

    get() {
        return database.getList("studentclassrooms");
    }

    getById(id) {
        return database.get("studentclassrooms", id);
    }

    create(studentclassroom) {
        return database.create("studentclassrooms", studentclassroom);
    }

    setId(studentclassroom) {
        return database.setId("studentclassrooms", studentclassroom.id, studentclassroom);
    }

    delete(id) {
        return database.delete("studentclassrooms", id);
    }

    update(id, studentclassroom) {
        return database.set("studentclassrooms", id, studentclassroom);
    }
}

module.exports = new StudentClassroomModel();
