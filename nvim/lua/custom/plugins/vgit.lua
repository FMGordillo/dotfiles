return {
  'tanvirtin/vgit.nvim',
  requires = {'nvim-lua/plenary.nvim'},
  config = function()
    require('vgit').setup()
  end
}
