import { defineConfig } from "astro/config";

import cloudflare from "@astrojs/cloudflare";

import { loadEnv } from "vite";
const { CF_PAGES_URL } = loadEnv(import.meta.env.MODE, process.cwd(), "");

const getSite = () => {
  if (CF_PAGES_URL) {
    return CF_PAGES_URL;
  } else {
    return "http://localhost:8788";
  }
};

// https://astro.build/config
export default defineConfig({
  output: "server",
  adapter: cloudflare({ mode: "directory" }),
  site: getSite(),
});
