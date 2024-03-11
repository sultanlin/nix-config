{
  # neotest-java,
  # sentiment-nvim,
  ...
} @ inputs: (final: prev: {
  vimPlugins = let
    mkNvimPlugin = src: name:
      prev.vimUtils.buildVimPlugin {
        inherit name src;
      };
  in
    # vimPlugins =
    prev.vimPlugins
    // {
      neotest-java = mkNvimPlugin inputs.neotest-java "neotest-java";
      sentiment-nvim = mkNvimPlugin inputs.sentiment-nvim "sentiment.nvim";
      # sentiment-nvim = mkNvimPlugin sentiment-nvim "sentiment.nvim";
    };
})
