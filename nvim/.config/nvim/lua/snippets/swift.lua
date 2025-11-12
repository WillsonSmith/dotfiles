local util = require("util")

return util.map(
  {
    {
      trigger = "pub",
      body = "public ${0}"
    },
    {
      trigger = "priv",
      body = "private $0"
    },
    {
      trigger = "if",
      body = [[
      if $1 {
        $2
      }$0
      ]]
    },
    {
      trigger = "ifl",
      body = [[
      if let $1 = ${2:$1} {
        $3
      }$0
      ]]
    },
    {
      trigger = "ifcl",
      body = [[
      if case let $1 = ${2:$1} {
        $3
      }$0
      ]]
    },
    {
      trigger = "func",
      body = [[
      func $1($2) $3{
        $0
      }
      ]]
    },
    {
      trigger = "funca",
      body = [[
      func $1($2) async $3{
        $0
      }
      ]]
    },
    {
      trigger = "guard",
      body = [[
      guard $1 else {
        $2
      }$0
      ]]
    },
    {
      trigger = "guardl",
      body = [[
      guard let $1 else {
        $2
      }$0
      ]]
    },
    {
      trigger = "main",
      body = [[
      @main public struct ${1:App} {
        public static func main() {
          $2
        }
      }$0
      ]]
    },
    {
      trigger = "uiview",
      body = [[
      struct $1: View {
        var body: some View {
          $2
        }
      }$0
      ]]
    },
    {
      trigger = "foundnetwork",
      body = [[
      #if canImport(FoundationNetworking)
        import FoundationNetworking
      #endif
      ]]
    },
    {
      trigger = "elp",
      body = [[
      .package(url: "https://github.com/sliemeobn/elementary.git", from: "0.5.5"),
      ]]
    },
  },
  function(snippet)
    snippet.body = util.dedent(snippet.body)
    return snippet
  end
)
