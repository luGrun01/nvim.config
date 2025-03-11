local lspconfig = require('lspconfig')

local python_executable = ''
if vim.fn.executable('ipython') then
  python_executable = 'ipython'
else
  python_executable = 'python'
end
local pylsp_command = 'pylsp'

-- Custom paths for directory search
local custom_search_paths = { '/Users/luana.grunheidt/Git/cortex/axonius-core', '/Users/luana.grunheidt/Git/cortex/adapters', '/Users/luana.grunheidt/Git/cortex/axonius-libs/src/libs/axonius-py', '/Users/luana.grunheidt/Git/cortex/axonius-libs/src/libs/axonius-py/axonius/mixins/'
}

local function add_project_lib_to_pythonpath(path)
  local project_lib_path = vim.fn.expand(path)
  local python_path = vim.fn.getenv('PYTHONPATH')

  if python_path == vim.NIL then
    python_path = ''
  else
    python_path = tostring(python_path)
  end

  if not python_path:match(project_lib_path) then
    vim.fn.setenv('PYTHONPATH', project_lib_path .. ':' .. python_path)
  end
end

for path_index = 1, 4 do
  add_project_lib_to_pythonpath(custom_search_paths[path_index])
end

lspconfig.pylsp.setup {
  cmd = { pylsp_command },  -- Default pylsp command
  settings = {
    pylsp = {
      plugins = {
        pyflakes = { enabled = true },
        pylint = {
          enabled = true,
          executable = python_executable .. '/pylint',
          args = { '--max-line-length=120' }
        }, -- Using default Python
        yapf = { enabled = true },
        flake8 = {
          enabled = true,
          maxLineLength = 120
        },
        jedi = {
          workspace = {
            extra_paths = { vim.fn.expand('/Users/luana.grunheidt/Git/cortex/axonius-libs/src/libs/axonius-py/axonius/mixins') },
          },
          extra_paths = { vim.fn.expand('/Users/luana.grunheidt/Git/cortex/axonius-libs/src/libs/axonius-py/axonius/mixins') },
        }
      },
      configurationSources = {"pylint"},
      extraPaths = custom_search_paths,
    },
  },
  root_dir = function(fname)
    return lspconfig.util.root_pattern(".git")(fname) or lspconfig.util.path.dirname(fname)
  end,
  on_attach = function(client, bufnr)
    -- Key mappings for LSP features
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local opts = { noremap = true, silent = true }

    vim.diagnostic.config({
      virtual_text = false,
    })

    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'ruc', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- Add any additional key mappings as necessary
  end
}

-- Add directory search paths for the Python environment
for _, path in ipairs(custom_search_paths) do
  vim.cmd('set path+=' .. path) -- Update Neovim's path setting for file searching
end
