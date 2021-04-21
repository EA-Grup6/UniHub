"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const morgan_1 = __importDefault(require("morgan"));
const path_1 = __importDefault(require("path"));
const app = express_1.default();
const index_1 = __importDefault(require("./routes/index"));
//settings
app.set('port', process.env.PORT || 4000); // definim la variable PORT 
// Middlewares
app.use(morgan_1.default('dev'));
app.use(express_1.default.json());
app.use(cors_1.default());
//Routes
app.use('/', index_1.default); //Configurem qui sera l'autoritat de les rutes que arribin amb /app
// this folder is for public documents ( A lo que puede acceder el navegador)
app.use('/uploads', express_1.default.static(path_1.default.resolve('uploads')));
exports.default = app;
