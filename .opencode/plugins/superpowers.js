import path from 'path';
import fs from 'fs';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const cache = { value: undefined, present: undefined };

const stripFrontmatter = (content) => {
  const match = content.match(/^---\n([\s\S]*?)\n---\n([\s\S]*)$/);
  return match ? match[2].trim() : content.trim();
};

export const SuperpowersPlugin = async () => {
  const superpowersSkillsDir = path.resolve(__dirname, '../../skills');

  const getBootstrap = () => {
    if (cache.present === true) return cache.value;
    if (cache.present === false) return null;

    const skillPath = path.join(superpowersSkillsDir, 'using-superpowers', 'SKILL.md');
    if (!fs.existsSync(skillPath)) {
      cache.present = false;
      return null;
    }

    const body = stripFrontmatter(fs.readFileSync(skillPath, 'utf8'));
    cache.value = `<EXTREMELY-IMPORTANT>\n${body}\n</EXTREMELY-IMPORTANT>`;
    cache.present = true;
    return cache.value;
  };

  return {
    // Register the vendored skills directory so OpenCode discovers them without
    // manual symlinks or config edits.
    config: async (config) => {
      config.skills = config.skills || {};
      config.skills.paths = config.skills.paths || [];
      if (!config.skills.paths.includes(superpowersSkillsDir)) {
        config.skills.paths.push(superpowersSkillsDir);
      }
    },

    // Inject the bootstrap into the first user message of each session.
    // The guard prevents double-injection if the message array is re-transformed.
    'experimental.chat.messages.transform': async (_input, output) => {
      const bootstrap = getBootstrap();
      if (!bootstrap || !output.messages.length) return;

      const firstUser = output.messages.find((m) => m.info.role === 'user');
      if (!firstUser || !firstUser.parts.length) return;
      if (firstUser.parts.some((p) => p.type === 'text' && p.text.includes('<EXTREMELY-IMPORTANT>'))) return;

      const ref = firstUser.parts[0];
      firstUser.parts.unshift({ ...ref, type: 'text', text: bootstrap });
    },
  };
};
