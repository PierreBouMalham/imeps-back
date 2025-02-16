import jwt from "jsonwebtoken";
import prisma from "./prisma.js";

export default async function authenticate(req, res, next) {
  try {
    const token = req.headers["authorization"];

    let { id } = jwt.verify(token?.split(" ")?.[1]?.trim(), "thesecretkey");

    const user = await prisma.user.findUnique({
      where: {
        id,
      },
    });

    if (user) {
      req.user = user;
      return next();
    }

    res.status(401).send("");
  } catch (err) {
    console.log("Error: ", err);
    res.status(401).send(err.message);
  }
}
