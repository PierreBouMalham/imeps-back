import express from "express";
import cors from "cors";
import routes from "./routes.js";

const app = express();

app.use(cors());
app.use(express.json());
app.use((req, res, next) => {
  if (req.query._method == "get") {
    req.method = "get";
  }
  next();
});

app.get("/", (req, res) => {
  res.send("IMEPS Server Running");
});

app.use(routes);

app.listen(8000, () => {
  console.log("Listening on PORT 8000");
});
