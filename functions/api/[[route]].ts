import { Hono } from "hono";
import { handle } from "hono/cloudflare-pages";
import type { KVNamespace } from "@cloudflare/workers-types";

type Bindings = {
  MIDZU: KVNamespace;
};

const daysSince = (start: number, finish: number) => {
  return Math.floor((finish - start) / (1000 * 60 * 60 * 24));
};

const app = new Hono<{ Bindings: Bindings }>().basePath("/api");

app.get("/health", (c) => {
  return c.json({ status: "ok" });
});

app.get("/days", async (c) => {
  const now = Date.now();
  const kv_namespace = c.env.MIDZU;
  const said = daysSince(
    Number(await kv_namespace.get("said", { type: "text" })),
    now
  );
  const lastStream = daysSince(
    Number(await kv_namespace.get("last_stream", { type: "text" })),
    now
  );
  return c.json({ said, lastStream });
});

export type AppRoute = typeof app;

export const onRequest = handle(app);
