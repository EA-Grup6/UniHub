"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const mongoose_1 = require("mongoose");
const schema = new mongoose_1.Schema({
    username: String,
    description: String,
    url: String
});
exports.default = mongoose_1.model('Hospital', schema);
