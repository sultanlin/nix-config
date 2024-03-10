{
  # neotest-java,
  sentiment-nvim,
  inputs,
  ...
}: (final: prev: let
  mkNvimPlugin = src: pname:
    prev.vimUtils.buildVimPlugin {
      inherit pname src;
    };
in {
  neotest-java = mkNvimPlugin inputs.neotest-java "neotest-java";
  # sentiment-nvim = mkNvimPlugin inputs.sentiment-nvim "sentiment.nvim";
  sentiment-nvim = mkNvimPlugin sentiment-nvim "sentiment.nvim";
})
# } @ inputs: (final: prev:
#   vimPlugins =
#     prev.vimPlugins
#     // { let
#     mkNvimPlugin = src: pname:
#     in
#       own-sentiment-nvim = prev.vimUtils.buildVimPlugin {
#         name = "sentiment.nvim";
#         src = sentiment-nvim;
#       };
#     };
#   mkNvimPlugin = src: pname:
#     prev.pkgs.vimUtils.buildVimPlugin {
#       inherit pname src;
#     };
# # in {
# #   neotest-java = mkNvimPlugin inputs.neotest-java "neotest-java";
# #   sentiment-nvim = mkNvimPlugin inputs.sentiment-nvim "sentiment.nvim";
# # }
# )
