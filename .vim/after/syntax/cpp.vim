
syn keyword cppType uint8 uint16 uint32 uint64 int8 int16 int32 int64 bool32 b32 u8 u16 u32 u64 s8 s16 s32 s64 f32 f64
syn keyword cppType v2 v3 v4 m3 m4
syn keyword cppType uint Array EmbeddedArray FixedArray ArrayView String StringView List
syn keyword cppType std vector unordered_map

" Highlight NOTE like TODO and FIXME in comments
syn keyword cTodo contained NOTE

if exists("g:cpp_function_highlight")
    syn match    cCustomParen    transparent "(" contains=cParen contains=cCppParen
    syn match    cCustomFunc     "\w\+(\@=" contains=cCustomParen
    " The \s* allows any number of spaces between the name and the parenthesis,
    " but I never separate those for functions.
    " syn match    cCustomFunc     "\w\+\s*(\@=" contains=cCustomParen
    " This colors functions with orange in gruvbox
    hi def link cCustomFunc Special

    syn keyword cppDefine NO_DISCARD BIT Defer VALIDATE VALIDATE_V countof arrsize assert ASSERT VERIFY REF
    syn keyword cppDefine META_FIELD META_STRUCT META_ENUM INVALID_INDEX CVAR

    "  Color defines with the Macro color
    hi def link cppDefine Macro
endif
