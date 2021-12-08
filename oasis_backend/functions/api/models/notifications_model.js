const database = require("../database");

// Here, we are implementing the class with Singleton design pattern

class NotificationModel {
    constructor() {
        if (this.instance) return this.instance;
        NotificationModel.instance = this;
    }

    get() {
        return database.getList("notifications");
    }

    getById(id) {
        return database.get("notifications", id);
    }

    create(notification) {
        return database.create("notifications", notification);
    }

    setId(notification) {
        return database.setId("notifications", notification.id, notification);
    }

    delete(id) {
        return database.delete("notifications", id);
    }

    update(id, notification) {
        return database.set("notifications", id, notification);
    }
}

module.exports = new NotificationModel();
