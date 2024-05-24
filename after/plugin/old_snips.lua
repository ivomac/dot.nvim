
-- snippet "lorem|ipsum" "Lorem Ipsum" br
-- Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tempor
-- tristique pulvinar. Vivamus a mattis est. Phasellus fermentum quam id quam
-- tempus, vitae sollicitudin dolor lacinia. Vestibulum placerat dui ullamcorper,
-- porttitor augue eu, pulvinar metus. Phasellus elementum id metus a ornare. Cras
-- sit amet semper mi. Donec vel lectus dolor. Aliquam non pharetra massa, at
-- pharetra odio. Pellentesque ultrices urna ut lorem rutrum, ut fringilla lorem
-- convallis. Cras tellus tortor, rhoncus sit amet orci eu, tempor porttitor justo.
-- endsnippet


-- {
--     "List comprehension": {
--         "prefix": "lc",
--         "body": "[${1:value} for ${2:value} in ${3:iterable}]$0",
--         "description": "List comprehension for creating a list based on existing lists."
--     },
--     "List comprehension if else": {
--         "prefix": "lcie",
--         "body": "[${1:value} if ${2:condition} else ${3:condition} for ${4:value} in ${5:iterable}]$0",
--         "description": "List comprehension for creating a list based on existing lists, with conditional if-else statement."
--     },
--     "List comprehension if filter": {
--         "prefix": "lci",
--         "body": "[${1:value} for ${2:value} in ${3:iterable} if ${4:condition}$0]",
--         "description": "List comprehension for creating a list based on existing lists, with conditional if statement."
--     },
--     "Dictionary comprehension": {
--         "prefix": "dc",
--         "body": "{${1:key}: ${2:value} for ${3:key}, ${4:value} in ${5:iterable}}$0",
--         "description": "Handy and faster way to create dictories based on existing dictionaries."
--     },
--     "Dictionary comprehension if filter": {
--         "prefix": "dci",
--         "body": "{${1:key}: ${2:value} for ${3:key}, ${4:value} in ${5:iterable} if ${6:condition}}$0",
--         "description": "Handy and faster way to create dictories based on existing dictionaries, with conditional if statement."
--     },
--     "Set comprehension": {
--         "prefix": "sc",
--         "body": "{${1:value} for ${2:value} in ${3:iterable}}$0",
--         "description": "Create a set based on existing iterables."
--     },
--     "Set Comprehension if filter": {
--         "prefix": "sci",
--         "body": "{${1:value} for ${2:value} in ${3:iterable} if ${4:condition}}$0",
--         "description": "Create a set based on existing iterables, with condition if statement."
--     },
--     "Generator comprehension": {
--         "prefix": "gc",
--         "body": "(${1:key} for ${2:value} in ${3:iterable})$0",
--         "description": "Create a generator based on existing iterables."
--     },
--     "Generator comprehension if filter": {
--         "prefix": "gci",
--         "body": "(${1:key} for ${2:value} in ${3:iterable} if ${4:condition})$0",
--         "description": "Create a generator based on existing iterables, with condition if statement."
--     }
-- }

-- snippet temp "Tempfile"
-- ${1:TMPFILE}="$(mktemp -t ${3:--suffix=${4:.SUFFIX}} ${2:`!p
-- snippet arr "lines to array" b
-- IFS=$'\n' $1=($($2))
-- snippet "fun|function" "function" br
-- function $1() {
-- 	$0
-- }
-- endsnippet

    -- "example1": {
    --     "prefix": "options",
    --     "body": [
    --         "whoa! :O"
    --     ],
    --     "luasnip": {
    --         "priority": 2000,
    --         "autotrigger": true,
    --         "wordTrig": false
    --     }
    -- }


-- snippet '(i)|(im)|(imp)' "import" br
-- import ${1}
-- endsnippet



-- snippet ^^ "over" iA
-- ^{$1}$0
-- endsnippet

-- snippet __ "under" iA
-- _{$1}$0
-- endsnippet

-- snippet '' "under" iA
-- \`\`$1''$0
-- endsnippet

-- snippet -> "rightarrow" iA
-- \rightarrow
-- endsnippet

-- snippet <- "leftarrow" iA
-- \leftarrow
-- endsnippet

-- snippet \leftarrow> "leftrightarrow" iA
-- \leftrightarrow
-- endsnippet

-- snippet => "implies" iA
-- \implies
-- endsnippet

-- snippet <= "implied by" iA
-- \impliedby
-- endsnippet

-- snippet \impliedby> "leftrightarrow" iA
-- \Leftrightarrow
-- endsnippet

-- snippet >= "greater or equal" iA
-- \geq
-- endsnippet

-- snippet =< "equal or less" iA
-- \leq
-- endsnippet

-- snippet >> "much greater" iA
-- \gg
-- endsnippet

-- snippet << "much less" iA
-- \ll
-- endsnippet

-- snippet ~~ "assimptotically equal" iA
-- \sim
-- endsnippet

-- snippet '=~|~=' "Approximate" riA
-- \approx
-- endsnippet

-- snippet == "definition" iA
-- \equiv$0
-- endsnippet

-- snippet != "not equals" iA
-- \neq$0
-- endsnippet

-- snippet ... "dots" iA
-- \dots
-- endsnippet

-- snippet ** "times" iA
-- \times$0
-- endsnippet

-- snippet \timeso "times" iA
-- \otimes$0
-- endsnippet

-- snippet (> "ket" iA
-- \\ket{${1:${VISUAL}}}$0
-- endsnippet

-- snippet <) "bra" iA
-- \\bra{${1:${VISUAL}}}$0
-- endsnippet

-- snippet <> "braket" iA
-- \\braket{${1:${VISUAL}}}$0
-- endsnippet

-- snippet || "abs" iA
-- \\|${1:${VISUAL}}\\|$0
-- endsnippet

-- snippet bigO "big O" iA
-- O\left( ${1:x}^{${2:n}} \right)
-- endsnippet

-- snippet '([^ ]+)/([^ ]+)' "Fraction" ri
-- \\frac{`!p snip.rv = match.group(1)`}{`!p snip.rv = match.group(2)`}$0
-- endsnippet

-- snippet '([^ ]+)/' "Fraction" ri
-- \\frac{`!p snip.rv = match.group(1)`}{$1}$0
-- endsnippet

-- snippet mc "mathclap" w
-- \mathclap{${1:${VISUAL}}}$0
-- endsnippet

-- snippet pair "pair" w
-- \langle${1:${VISUAL}}\rangle$0
-- endsnippet

-- snippet / "fraction" w
-- \frac{$1}{$2}$0
-- endsnippet

-- snippet \ "math object" w
-- \\$1{${2:${VISUAL}}}$0
-- endsnippet

-- snippet \\ "double math object" w
-- \\$1{${2:${VISUAL}}}{$3}$0
-- endsnippet

-- snippet sq "\sqrt{}" w
-- \sqrt{${1:${VISUAL}}} $0
-- endsnippet

-- snippet inf "infinity" w
-- \infty $0
-- endsnippet

-- snippet abs "abs" w
-- \left\lvert $1 \right\rvert$0
-- endsnippet

-- snippet ceil "ceil" w
-- \left\lceil $1 \right\rceil $0
-- endsnippet

-- snippet floor "floor" w
-- \left\lfloor $1 \right\rfloor$0
-- endsnippet

-- snippet dv "Derivative" w
-- \dv[${1:${VISUAL}}]{${2}}{${3}}
-- endsnippet

-- snippet pdv "Partial Derivative" w
-- \pdv[${1:${VISUAL}}]{${2}}{${3}}
-- endsnippet

-- snippet int "integral" w
-- \int_{${1:-\infty}}^{${2:\infty}} ${4:${VISUAL}} d${3:t}$0
-- endsnippet

-- snippet sum "sum" w
-- \sum_{${1:n=0}}^{${2:\infty}} ${3:${VISUAL}}$0
-- endsnippet

-- snippet lim "limit" w
-- \lim_{${1:n} \to ${2:\infty}}
-- endsnippet

-- snippet prod "product" w
-- \prod_{${1:n=${2:1}}}^{${3:\infty}} ${4:${VISUAL}} $0
-- endsnippet



