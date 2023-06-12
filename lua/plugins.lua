-- ensure the packer plugin manager is installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

COC_EXTENSIONS = {
    'coc-tsserver',
    'coc-css',
    'coc-html',
    'coc-emmet',
    'coc-rust-analyzer'
}

local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

    use 'morhetz/gruvbox'

    use 'ryanoasis/vim-devicons'
    use 'nvim-tree/nvim-web-devicons'
    
    use 'nvim-tree/nvim-tree.lua'
    use 'nvim-lualine/lualine.nvim'

    use 'nanozuki/tabby.nvim'

    use {
        'neoclide/coc.nvim',
        run = 'yarn install --frozen-lockfile',
        config = function()
            if vim.fn.exists(':CocInstall') > 0 then
                vim.cmd{ cmd = 'CocInstall', args = COC_EXTENSIONS }
            end
        end
    }
end)

-- the first run will install packer and our plugins
if packer_bootstrap then
  require("packer").sync()
  return
end
