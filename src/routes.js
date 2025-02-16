import express from "express";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import prisma from "./prisma.js";
import authenticate from "./authMiddleware.js";

const router = express.Router();

const entities = [
  {
    prisma: "student",
    url: "students",
    include: {
      department: true,
    },
  },
  {
    prisma: "department",
    url: "departments",
  },
  {
    prisma: "country",
    url: "countries",
  },
  {
    prisma: "convention",
    url: "conventions",
  },
  {
    prisma: "university",
    url: "universities",
  },
  {
    prisma: "diploma",
    url: "diplomas",
  },
  {
    prisma: "parcours",
    url: "parcours",
  },
  {
    prisma: "scholarship",
    url: "scholarships",
  },
  {
    prisma: "application",
    url: "applications",
  },
  {
    prisma: "country",
    url: "countries",
  },
  {
    prisma: "application",
    url: "applications",
  },
];

entities.forEach((entity) => {
  router.get(`/${entity.url}`, authenticate, async (req, res) => {
    try {
      const items = await prisma[entity.prisma].findMany(req.body);
      //console.log("READ MANY ENTITY: ", entity.url);
      console.log("BODY: ", req.body);
      res.send(items);
    } catch (err) {
      res.status(500).send(err.message);
    }
  });

  router.get(`/${entity.url}/:id`, authenticate, async (req, res) => {
    try {
      const items = await prisma[entity.prisma].findUnique({
        where: {
          id: req.params.id,
        },
      });
      res.send(items);
    } catch (err) {
      res.status(500).send(err.message);
    }
  });

  router.post(`/${entity.url}`, authenticate, async (req, res) => {
    try {
      console.log("CREATE ENTITY: ", entity.url);
      console.log("Body: ", req.body);
      if (req.body.scholarships) {
        req.body.scholarships = {
          connect: req.body.scholarships.map((id) => ({ id })),
        };
      }
      const items = await prisma[entity.prisma].create({ data: req.body });
      res.send(items);
    } catch (err) {
      res.status(500).send(err.message);
    }
  });

  router.put(`/${entity.url}/:id`, authenticate, async (req, res) => {
    try {
      if (req.body.scholarships) {
        req.body.scholarships = {
          set: req.body.scholarships.map((id) => ({ id })),
        };
      }

      console.log("Req.body: ", req.body);
      const items = await prisma[entity.prisma].update({
        where: {
          id: req.params.id,
        },
        data: req.body,
      });
      res.send(items);
    } catch (err) {
      console.log(err.message);
      res.status(500).send(err.message);
    }
  });

  router.delete(`/${entity.url}/:id`, authenticate, async (req, res) => {
    try {
      console.log("DELETE ENTITY: ", entity.url, req.params.id);
      const items = await prisma[entity.prisma].delete({
        where: {
          id: req.params.id,
        },
      });
      res.send(items);
    } catch (err) {
      console.log("Error: ", err.message);
      res.status(500).send(err.message);
    }
  });
});

router.post("/login", async (req, res) => {
  try {
    const user = await prisma.user.findUnique({
      where: {
        email: req.body.email,
      },
    });

    const samePassword = await bcrypt.compare(req.body.password, user.password);
    if (samePassword) {
      const token = jwt.sign({ id: user.id }, "thesecretkey", {
        expiresIn: "30d",
      });

      return res.send(token);
    }

    res.status(500).send("");
  } catch (err) {
    res.status(500).send(err.message);
  }
});

router.post("/register", async (req, res) => {
  try {
    const user = await prisma.user.create({
      data: {
        email: req.body.email,
        password: bcrypt.hashSync(req.body.password),
        firstName: req.body.firstName,
        lastName: req.body.lastName,
      },
    });

    const token = jwt.sign({ id: user.id }, "thesecretkey", {
      expiresIn: "30d",
    });

    if (token) return res.send(token);

    res.status(500).send("");
  } catch (err) {
    res.status(500).send(err.message);
  }
});

router.get("/users/me", authenticate, async (req, res) => {
  try {
    res.send(req.user);
  } catch (err) {
    res.status(500).send(err.message);
  }
});

export default router;
