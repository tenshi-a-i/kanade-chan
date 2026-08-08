FROM node:24-alpine

WORKDIR /app

RUN addgroup -S airi && adduser -S airi -G airi

RUN corepack enable

COPY . .

RUN --mount=type=cache,id=pnpm-store,target=/root/.pnpm-store \
    pnpm install --frozen-lockfile --ignore-scripts

# Backend dependencies
RUN pnpm -F @proj-airi/drizzle-migration build

RUN pnpm -F @proj-airi/server-sdk-shared build

# Build API
RUN pnpm -F @proj-airi/api-server build

EXPOSE 3000

USER airi

CMD ["pnpm", "-F", "@proj-airi/api-server", "run", "server", "api"]
