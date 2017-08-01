# NSX Website

## About

Visual, functional and performance improvements to the existing NSX website.

The project is a fairly simple sass build with server and watch. It builds the css and also copies any static html site files into the `/build` directory.

All initial sass files were created by converting the latest live css into sass.

## To-do

- Set up production build (currently only suitable for dev)
- Configure uncss once all site files provided

## Installation

1. Clone the repo to your machine
2. Terminal into the directory
3. Run command `yarn install`
4. Once installed, run command the desired command:
  - `npm run dev` to build, start server and watch a local dev build
  - `npm run preview` to build a preview for upload to S3