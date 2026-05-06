#!/usr/bin/env node
import { existsSync } from 'node:fs';
import { resolve } from 'node:path';

const repoRoot = resolve(import.meta.dirname, '..');
const piSkillsModule = '/usr/local/lib/node_modules/@mariozechner/pi-coding-agent/dist/core/skills.js';

if (!existsSync(piSkillsModule)) {
  console.error('Pi skill loader not found at:', piSkillsModule);
  console.error('Install Pi locally, or validate manually with: pi --skill ./skills --no-session -p "list loaded skills"');
  process.exit(1);
}

const { loadSkills } = await import(piSkillsModule);
const result = loadSkills({
  cwd: repoRoot,
  agentDir: resolve(repoRoot, '.pi-test-agent'),
  skillPaths: [resolve(repoRoot, 'skills')],
  includeDefaults: false,
});

console.log(`Loaded ${result.skills.length} skills from ./skills`);

for (const skill of result.skills) {
  const hidden = skill.disableModelInvocation ? ' (manual invocation only)' : '';
  console.log(`- ${skill.name}${hidden}`);
}

if (result.diagnostics.length > 0) {
  console.error('\nDiagnostics:');
  for (const diagnostic of result.diagnostics) {
    console.error(`- [${diagnostic.type}] ${diagnostic.message}: ${diagnostic.path}`);
  }
  process.exit(1);
}

console.log('\nPi skill validation passed with no diagnostics.');
