import antfu from '@antfu/eslint-config'

export default antfu({
  stylistic: {
    indent: 2,
    quotes: 'single',
  },
  ignores: [
    '.github',
  ],
  rules: {
    'no-console': 'off',
  },
})
