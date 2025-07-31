# Helpjuice Internship Test — Search Analytics

This is a Rails-only app that tracks what users search in real-time, avoiding the pyramid problem by storing only the most complete version of each search.

## Features
- No frontend JS — pure Rails form with styled HTML/CSS
- Tracks search terms per user (IP-based)
- Stores only the most complete query
- Analytics page shows most popular search terms

## Run locally

```bash
bundle install
rails db:create db:migrate
rails server
