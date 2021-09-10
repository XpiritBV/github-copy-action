#!/bin/sh -l


  const fs = require('fs').promises
  const path = require('path')
  const target = path.resolve(process.env.TARGET_FOLDER)
  process.chdir(process.env.SOURCE_FOLDER || '.')
  if (process.env.CLEAN_TARGET_FOLDER === 'true') await io.rmRF(target)
  const flattenFolders = process.env.FLATTEN_FOLDERS === 'true'
  const options = {force: process.env.OVERWRITE === 'true'}
  const globber = await glob.create(process.env.CONTENTS || '**')
  for await (const file of globber.globGenerator()) {
    if ((await fs.lstat(file)).isDirectory()) continue
    const filename = flattenFolders ? path.basename(file) : file.substring(process.cwd().length)
    const dest = path.join(target, filename)
    await io.mkdirP(path.dirname(dest))
    await io.cp(file, dest, options)
  }
