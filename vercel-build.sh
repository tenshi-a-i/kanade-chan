#!/bin/bash

pnpm -F @proj-airi/stage-web run build && \
pnpm -F @proj-airi/docs run build:base && \
mv ./docs/.vitepress/dist ./apps/stage-web/dist/docs && \
cp ./apps/stage-web/dist/docs/sitemap.xml ./apps/stage-web/dist/sitemap.xml && \
pnpm -F @proj-airi/stage-ui run story:build && \
mv ./packages/stage-ui/.histoire/dist ./apps/stage-web/dist/ui
