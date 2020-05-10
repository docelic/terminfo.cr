private module TerminfoKeyValidator
  def valid?
    {% begin %}
      value <= {{ @type }}::{{ @type.constants.last }}.value
    {% end %}
  end
end

struct Enum
  include TerminfoKeyValidator
end

module Terminfo::Keys
  enum Booleans
    # Order is important

    AutoLeftMargin
    AutoRightMargin
    NoEscCtlc
    CeolStandoutGlitch
    EatNewlineGlitch
    EraseOverstrike
    GenericType
    HardCopy
    HasMetaKey
    HasStatusLine
    InsertNullGlitch
    MemoryAbove
    MemoryBelow
    MoveInsertMode
    MoveStandoutMode
    OverStrike
    StatusLineEscOk
    DestTabsMagicSmso
    TildeGlitch
    TransparentUnderline
    XonXoff
    NeedsXonXoff
    PrtrSilent
    HardCursor
    NonRevRmcup
    NoPadChar
    NonDestScrollRegion
    CanChange
    BackColorErase
    HueLightnessSaturation
    ColAddrGlitch
    CrCancelsMicroMode
    HasPrintWheel
    RowAddrGlitch
    SemiAutoRightMargin
    CpiChangesRes
    LpiChangesRes
    BackspacesWithBs
    CrtNoScrolling
    NoCorrectlyWorkingCr
    GnuHasMetaKey
    LinefeedIsNewline
    HasHardwareTabs
    ReturnDoesClrEol
  end

  enum Numbers
    # Order is important

    Columns
    InitTabs
    Lines
    LinesOfMemory
    MagicCookieGlitch
    PaddingBaudRate
    VirtualTerminal
    WidthStatusLine
    NumLabels
    LabelHeight
    LabelWidth
    MaxAttributes
    MaximumWindows
    MaxColors
    MaxPairs
    NoColorVideo
    BufferCapacity
    DotVertSpacing
    DotHorzSpacing
    MaxMicroAddress
    MaxMicroJump
    MicroColSize
    MicroLineSize
    NumberOfPins
    OutputResChar
    OutputResLine
    OutputResHorzInch
    OutputResVertInch
    PrintRate
    WideCharSize
    Buttons
    BitImageEntwining
    BitImageType
    MagicCookieGlitchUl
    CarriageReturnDelay
    NewLineDelay
    BackspaceDelay
    HorizontalTabDelay
    NumberOfFunctionKeys
  end

  enum Strings
    # Order is important

    BackTab
    Bell
    CarriageReturn
    ChangeScrollRegion
    ClearAllTabs
    ClearScreen
    ClrEol
    ClrEos
    ColumnAddress
    CommandCharacter
    CursorAddress
    CursorDown
    CursorHome
    CursorInvisible
    CursorLeft
    CursorMemAddress
    CursorNormal
    CursorRight
    CursorToLl
    CursorUp
    CursorVisible
    DeleteCharacter
    DeleteLine
    DisStatusLine
    DownHalfLine
    EnterAltCharsetMode
    EnterBlinkMode
    EnterBoldMode
    EnterCaMode
    EnterDeleteMode
    EnterDimMode
    EnterInsertMode
    EnterSecureMode
    EnterProtectedMode
    EnterReverseMode
    EnterStandoutMode
    EnterUnderlineMode
    EraseChars
    ExitAltCharsetMode
    ExitAttributeMode
    ExitCaMode
    ExitDeleteMode
    ExitInsertMode
    ExitStandoutMode
    ExitUnderlineMode
    FlashScreen
    FormFeed
    FromStatusLine
    Init1string
    Init2string
    Init3string
    InitFile
    InsertCharacter
    InsertLine
    InsertPadding
    KeyBackspace
    KeyCatab
    KeyClear
    KeyCtab
    KeyDc
    KeyDl
    KeyDown
    KeyEic
    KeyEol
    KeyEos
    KeyF0
    KeyF1
    KeyF10
    KeyF2
    KeyF3
    KeyF4
    KeyF5
    KeyF6
    KeyF7
    KeyF8
    KeyF9
    KeyHome
    KeyIc
    KeyIl
    KeyLeft
    KeyLl
    KeyNpage
    KeyPpage
    KeyRight
    KeySf
    KeySr
    KeyStab
    KeyUp
    KeypadLocal
    KeypadXmit
    LabF0
    LabF1
    LabF10
    LabF2
    LabF3
    LabF4
    LabF5
    LabF6
    LabF7
    LabF8
    LabF9
    MetaOff
    MetaOn
    Newline
    PadChar
    ParmDch
    ParmDeleteLine
    ParmDownCursor
    ParmIch
    ParmIndex
    ParmInsertLine
    ParmLeftCursor
    ParmRightCursor
    ParmRindex
    ParmUpCursor
    PkeyKey
    PkeyLocal
    PkeyXmit
    PrintScreen
    PrtrOff
    PrtrOn
    RepeatChar
    Reset1string
    Reset2string
    Reset3string
    ResetFile
    RestoreCursor
    RowAddress
    SaveCursor
    ScrollForward
    ScrollReverse
    SetAttributes
    SetTab
    SetWindow
    Tab
    ToStatusLine
    UnderlineChar
    UpHalfLine
    InitProg
    KeyA1
    KeyA3
    KeyB2
    KeyC1
    KeyC3
    PrtrNon
    CharPadding
    AcsChars
    PlabNorm
    KeyBtab
    EnterXonMode
    ExitXonMode
    EnterAmMode
    ExitAmMode
    XonCharacter
    XoffCharacter
    EnaAcs
    LabelOn
    LabelOff
    KeyBeg
    KeyCancel
    KeyClose
    KeyCommand
    KeyCopy
    KeyCreate
    KeyEnd
    KeyEnter
    KeyExit
    KeyFind
    KeyHelp
    KeyMark
    KeyMessage
    KeyMove
    KeyNext
    KeyOpen
    KeyOptions
    KeyPrevious
    KeyPrint
    KeyRedo
    KeyReference
    KeyRefresh
    KeyReplace
    KeyRestart
    KeyResume
    KeySave
    KeySuspend
    KeyUndo
    KeySbeg
    KeyScancel
    KeyScommand
    KeyScopy
    KeyScreate
    KeySdc
    KeySdl
    KeySelect
    KeySend
    KeySeol
    KeySexit
    KeySfind
    KeyShelp
    KeyShome
    KeySic
    KeySleft
    KeySmessage
    KeySmove
    KeySnext
    KeySoptions
    KeySprevious
    KeySprint
    KeySredo
    KeySreplace
    KeySright
    KeySrsume
    KeySsave
    KeySsuspend
    KeySundo
    ReqForInput
    KeyF11
    KeyF12
    KeyF13
    KeyF14
    KeyF15
    KeyF16
    KeyF17
    KeyF18
    KeyF19
    KeyF20
    KeyF21
    KeyF22
    KeyF23
    KeyF24
    KeyF25
    KeyF26
    KeyF27
    KeyF28
    KeyF29
    KeyF30
    KeyF31
    KeyF32
    KeyF33
    KeyF34
    KeyF35
    KeyF36
    KeyF37
    KeyF38
    KeyF39
    KeyF40
    KeyF41
    KeyF42
    KeyF43
    KeyF44
    KeyF45
    KeyF46
    KeyF47
    KeyF48
    KeyF49
    KeyF50
    KeyF51
    KeyF52
    KeyF53
    KeyF54
    KeyF55
    KeyF56
    KeyF57
    KeyF58
    KeyF59
    KeyF60
    KeyF61
    KeyF62
    KeyF63
    ClrBol
    ClearMargins
    SetLeftMargin
    SetRightMargin
    LabelFormat
    SetClock
    DisplayClock
    RemoveClock
    CreateWindow
    GotoWindow
    Hangup
    DialPhone
    QuickDial
    Tone
    Pulse
    FlashHook
    FixedPause
    WaitTone
    User0
    User1
    User2
    User3
    User4
    User5
    User6
    User7
    User8
    User9
    OrigPair
    OrigColors
    InitializeColor
    InitializePair
    SetColorPair
    SetForeground
    SetBackground
    ChangeCharPitch
    ChangeLinePitch
    ChangeResHorz
    ChangeResVert
    DefineChar
    EnterDoublewideMode
    EnterDraftQuality
    EnterItalicsMode
    EnterLeftwardMode
    EnterMicroMode
    EnterNearLetterQuality
    EnterNormalQuality
    EnterShadowMode
    EnterSubscriptMode
    EnterSuperscriptMode
    EnterUpwardMode
    ExitDoublewideMode
    ExitItalicsMode
    ExitLeftwardMode
    ExitMicroMode
    ExitShadowMode
    ExitSubscriptMode
    ExitSuperscriptMode
    ExitUpwardMode
    MicroColumnAddress
    MicroDown
    MicroLeft
    MicroRight
    MicroRowAddress
    MicroUp
    OrderOfPins
    ParmDownMicro
    ParmLeftMicro
    ParmRightMicro
    ParmUpMicro
    SelectCharSet
    SetBottomMargin
    SetBottomMarginParm
    SetLeftMarginParm
    SetRightMarginParm
    SetTopMargin
    SetTopMarginParm
    StartBitImage
    StartCharSetDef
    StopBitImage
    StopCharSetDef
    SubscriptCharacters
    SuperscriptCharacters
    TheseCauseCr
    ZeroMotion
    CharSetNames
    KeyMouse
    MouseInfo
    ReqMousePos
    GetMouse
    SetAForeground
    SetABackground
    PkeyPlab
    DeviceType
    CodeSetInit
    Set0DesSeq
    Set1DesSeq
    Set2DesSeq
    Set3DesSeq
    SetLrMargin
    SetTbMargin
    BitImageRepeat
    BitImageNewline
    BitImageCarriageReturn
    ColorNames
    DefineBitImageRegion
    EndBitImageRegion
    SetColorBand
    SetPageLength
    DisplayPcChar
    EnterPcCharsetMode
    ExitPcCharsetMode
    EnterScancodeMode
    ExitScancodeMode
    PcTermOptions
    ScancodeEscape
    AltScancodeEsc
    EnterHorizontalHlMode
    EnterLeftHlMode
    EnterLowHlMode
    EnterRightHlMode
    EnterTopHlMode
    EnterVerticalHlMode
    SetAAttributes
    SetPglenInch
    TermcapInit2
    TermcapReset
    LinefeedIfNotLf
    BackspaceIfNotBs
    OtherNonFunctionKeys
    ArrowKeyMap
    AcsUlcorner
    AcsLlcorner
    AcsUrcorner
    AcsLrcorner
    AcsLtee
    AcsRtee
    AcsBtee
    AcsTtee
    AcsHline
    AcsVline
    AcsPlus
    MemoryLock
    MemoryUnlock
    BoxChars1
  end
end

module Terminfo::KeyNames
  record Entry, full : String, short : String do
    def to_s(io)
      @full
    end
  end

  Booleans = [
    # Order is important

    Entry.new(full: "auto_left_margin", short: "bw"),
    Entry.new(full: "auto_right_margin", short: "am"),
    Entry.new(full: "no_esc_ctlc", short: "xsb"),
    Entry.new(full: "ceol_standout_glitch", short: "xhp"),
    Entry.new(full: "eat_newline_glitch", short: "xenl"),
    Entry.new(full: "erase_overstrike", short: "eo"),
    Entry.new(full: "generic_type", short: "gn"),
    Entry.new(full: "hard_copy", short: "hc"),
    Entry.new(full: "has_meta_key", short: "km"),
    Entry.new(full: "has_status_line", short: "hs"),
    Entry.new(full: "insert_null_glitch", short: "in"),
    Entry.new(full: "memory_above", short: "db"),
    Entry.new(full: "memory_below", short: "da"),
    Entry.new(full: "move_insert_mode", short: "mir"),
    Entry.new(full: "move_standout_mode", short: "msgr"),
    Entry.new(full: "over_strike", short: "os"),
    Entry.new(full: "status_line_esc_ok", short: "eslok"),
    Entry.new(full: "dest_tabs_magic_smso", short: "xt"),
    Entry.new(full: "tilde_glitch", short: "hz"),
    Entry.new(full: "transparent_underline", short: "ul"),
    Entry.new(full: "xon_xoff", short: "xon"),
    Entry.new(full: "needs_xon_xoff", short: "nxon"),
    Entry.new(full: "prtr_silent", short: "mc5i"),
    Entry.new(full: "hard_cursor", short: "chts"),
    Entry.new(full: "non_rev_rmcup", short: "nrrmc"),
    Entry.new(full: "no_pad_char", short: "npc"),
    Entry.new(full: "non_dest_scroll_region", short: "ndscr"),
    Entry.new(full: "can_change", short: "ccc"),
    Entry.new(full: "back_color_erase", short: "bce"),
    Entry.new(full: "hue_lightness_saturation", short: "hls"),
    Entry.new(full: "col_addr_glitch", short: "xhpa"),
    Entry.new(full: "cr_cancels_micro_mode", short: "crxm"),
    Entry.new(full: "has_print_wheel", short: "daisy"),
    Entry.new(full: "row_addr_glitch", short: "xvpa"),
    Entry.new(full: "semi_auto_right_margin", short: "sam"),
    Entry.new(full: "cpi_changes_res", short: "cpix"),
    Entry.new(full: "lpi_changes_res", short: "lpix"),
    Entry.new(full: "backspaces_with_bs", short: "OTbs"),
    Entry.new(full: "crt_no_scrolling", short: "OTns"),
    Entry.new(full: "no_correctly_working_cr", short: "OTnc"),
    Entry.new(full: "gnu_has_meta_key", short: "OTMT"),
    Entry.new(full: "linefeed_is_newline", short: "OTNL"),
    Entry.new(full: "has_hardware_tabs", short: "OTpt"),
    Entry.new(full: "return_does_clr_eol", short: "OTxr"),
  ]

  Numbers = [
    # Order is important

    Entry.new(full: "columns", short: "cols"),
    Entry.new(full: "init_tabs", short: "it"),
    Entry.new(full: "lines", short: "lines"),
    Entry.new(full: "lines_of_memory", short: "lm"),
    Entry.new(full: "magic_cookie_glitch", short: "xmc"),
    Entry.new(full: "padding_baud_rate", short: "pb"),
    Entry.new(full: "virtual_terminal", short: "vt"),
    Entry.new(full: "width_status_line", short: "wsl"),
    Entry.new(full: "num_labels", short: "nlab"),
    Entry.new(full: "label_height", short: "lh"),
    Entry.new(full: "label_width", short: "lw"),
    Entry.new(full: "max_attributes", short: "ma"),
    Entry.new(full: "maximum_windows", short: "wnum"),
    Entry.new(full: "max_colors", short: "colors"),
    Entry.new(full: "max_pairs", short: "pairs"),
    Entry.new(full: "no_color_video", short: "ncv"),
    Entry.new(full: "buffer_capacity", short: "bufsz"),
    Entry.new(full: "dot_vert_spacing", short: "spinv"),
    Entry.new(full: "dot_horz_spacing", short: "spinh"),
    Entry.new(full: "max_micro_address", short: "maddr"),
    Entry.new(full: "max_micro_jump", short: "mjump"),
    Entry.new(full: "micro_col_size", short: "mcs"),
    Entry.new(full: "micro_line_size", short: "mls"),
    Entry.new(full: "number_of_pins", short: "npins"),
    Entry.new(full: "output_res_char", short: "orc"),
    Entry.new(full: "output_res_line", short: "orl"),
    Entry.new(full: "output_res_horz_inch", short: "orhi"),
    Entry.new(full: "output_res_vert_inch", short: "orvi"),
    Entry.new(full: "print_rate", short: "cps"),
    Entry.new(full: "wide_char_size", short: "widcs"),
    Entry.new(full: "buttons", short: "btns"),
    Entry.new(full: "bit_image_entwining", short: "bitwin"),
    Entry.new(full: "bit_image_type", short: "bitype"),
    Entry.new(full: "magic_cookie_glitch_ul", short: "UTug"),
    Entry.new(full: "carriage_return_delay", short: "OTdC"),
    Entry.new(full: "new_line_delay", short: "OTdN"),
    Entry.new(full: "backspace_delay", short: "OTdB"),
    Entry.new(full: "horizontal_tab_delay", short: "OTdT"),
    Entry.new(full: "number_of_function_keys", short: "OTkn"),
  ]

  Strings = [
    # Order is important

    Entry.new(full: "back_tab", short: "cbt"),
    Entry.new(full: "bell", short: "bel"),
    Entry.new(full: "carriage_return", short: "cr"),
    Entry.new(full: "change_scroll_region", short: "csr"),
    Entry.new(full: "clear_all_tabs", short: "tbc"),
    Entry.new(full: "clear_screen", short: "clear"),
    Entry.new(full: "clr_eol", short: "el"),
    Entry.new(full: "clr_eos", short: "ed"),
    Entry.new(full: "column_address", short: "hpa"),
    Entry.new(full: "command_character", short: "cmdch"),
    Entry.new(full: "cursor_address", short: "cup"),
    Entry.new(full: "cursor_down", short: "cud1"),
    Entry.new(full: "cursor_home", short: "home"),
    Entry.new(full: "cursor_invisible", short: "civis"),
    Entry.new(full: "cursor_left", short: "cub1"),
    Entry.new(full: "cursor_mem_address", short: "mrcup"),
    Entry.new(full: "cursor_normal", short: "cnorm"),
    Entry.new(full: "cursor_right", short: "cuf1"),
    Entry.new(full: "cursor_to_ll", short: "ll"),
    Entry.new(full: "cursor_up", short: "cuu1"),
    Entry.new(full: "cursor_visible", short: "cvvis"),
    Entry.new(full: "delete_character", short: "dch1"),
    Entry.new(full: "delete_line", short: "dl1"),
    Entry.new(full: "dis_status_line", short: "dsl"),
    Entry.new(full: "down_half_line", short: "hd"),
    Entry.new(full: "enter_alt_charset_mode", short: "smacs"),
    Entry.new(full: "enter_blink_mode", short: "blink"),
    Entry.new(full: "enter_bold_mode", short: "bold"),
    Entry.new(full: "enter_ca_mode", short: "smcup"),
    Entry.new(full: "enter_delete_mode", short: "smdc"),
    Entry.new(full: "enter_dim_mode", short: "dim"),
    Entry.new(full: "enter_insert_mode", short: "smir"),
    Entry.new(full: "enter_secure_mode", short: "invis"),
    Entry.new(full: "enter_protected_mode", short: "prot"),
    Entry.new(full: "enter_reverse_mode", short: "rev"),
    Entry.new(full: "enter_standout_mode", short: "smso"),
    Entry.new(full: "enter_underline_mode", short: "smul"),
    Entry.new(full: "erase_chars", short: "ech"),
    Entry.new(full: "exit_alt_charset_mode", short: "rmacs"),
    Entry.new(full: "exit_attribute_mode", short: "sgr0"),
    Entry.new(full: "exit_ca_mode", short: "rmcup"),
    Entry.new(full: "exit_delete_mode", short: "rmdc"),
    Entry.new(full: "exit_insert_mode", short: "rmir"),
    Entry.new(full: "exit_standout_mode", short: "rmso"),
    Entry.new(full: "exit_underline_mode", short: "rmul"),
    Entry.new(full: "flash_screen", short: "flash"),
    Entry.new(full: "form_feed", short: "ff"),
    Entry.new(full: "from_status_line", short: "fsl"),
    Entry.new(full: "init_1string", short: "is1"),
    Entry.new(full: "init_2string", short: "is2"),
    Entry.new(full: "init_3string", short: "is3"),
    Entry.new(full: "init_file", short: "if"),
    Entry.new(full: "insert_character", short: "ich1"),
    Entry.new(full: "insert_line", short: "il1"),
    Entry.new(full: "insert_padding", short: "ip"),
    Entry.new(full: "key_backspace", short: "kbs"),
    Entry.new(full: "key_catab", short: "ktbc"),
    Entry.new(full: "key_clear", short: "kclr"),
    Entry.new(full: "key_ctab", short: "kctab"),
    Entry.new(full: "key_dc", short: "kdch1"),
    Entry.new(full: "key_dl", short: "kdl1"),
    Entry.new(full: "key_down", short: "kcud1"),
    Entry.new(full: "key_eic", short: "krmir"),
    Entry.new(full: "key_eol", short: "kel"),
    Entry.new(full: "key_eos", short: "ked"),
    Entry.new(full: "key_f0", short: "kf0"),
    Entry.new(full: "key_f1", short: "kf1"),
    Entry.new(full: "key_f10", short: "kf10"),
    Entry.new(full: "key_f2", short: "kf2"),
    Entry.new(full: "key_f3", short: "kf3"),
    Entry.new(full: "key_f4", short: "kf4"),
    Entry.new(full: "key_f5", short: "kf5"),
    Entry.new(full: "key_f6", short: "kf6"),
    Entry.new(full: "key_f7", short: "kf7"),
    Entry.new(full: "key_f8", short: "kf8"),
    Entry.new(full: "key_f9", short: "kf9"),
    Entry.new(full: "key_home", short: "khome"),
    Entry.new(full: "key_ic", short: "kich1"),
    Entry.new(full: "key_il", short: "kil1"),
    Entry.new(full: "key_left", short: "kcub1"),
    Entry.new(full: "key_ll", short: "kll"),
    Entry.new(full: "key_npage", short: "knp"),
    Entry.new(full: "key_ppage", short: "kpp"),
    Entry.new(full: "key_right", short: "kcuf1"),
    Entry.new(full: "key_sf", short: "kind"),
    Entry.new(full: "key_sr", short: "kri"),
    Entry.new(full: "key_stab", short: "khts"),
    Entry.new(full: "key_up", short: "kcuu1"),
    Entry.new(full: "keypad_local", short: "rmkx"),
    Entry.new(full: "keypad_xmit", short: "smkx"),
    Entry.new(full: "lab_f0", short: "lf0"),
    Entry.new(full: "lab_f1", short: "lf1"),
    Entry.new(full: "lab_f10", short: "lf10"),
    Entry.new(full: "lab_f2", short: "lf2"),
    Entry.new(full: "lab_f3", short: "lf3"),
    Entry.new(full: "lab_f4", short: "lf4"),
    Entry.new(full: "lab_f5", short: "lf5"),
    Entry.new(full: "lab_f6", short: "lf6"),
    Entry.new(full: "lab_f7", short: "lf7"),
    Entry.new(full: "lab_f8", short: "lf8"),
    Entry.new(full: "lab_f9", short: "lf9"),
    Entry.new(full: "meta_off", short: "rmm"),
    Entry.new(full: "meta_on", short: "smm"),
    Entry.new(full: "newline", short: "nel"),
    Entry.new(full: "pad_char", short: "pad"),
    Entry.new(full: "parm_dch", short: "dch"),
    Entry.new(full: "parm_delete_line", short: "dl"),
    Entry.new(full: "parm_down_cursor", short: "cud"),
    Entry.new(full: "parm_ich", short: "ich"),
    Entry.new(full: "parm_index", short: "indn"),
    Entry.new(full: "parm_insert_line", short: "il"),
    Entry.new(full: "parm_left_cursor", short: "cub"),
    Entry.new(full: "parm_right_cursor", short: "cuf"),
    Entry.new(full: "parm_rindex", short: "rin"),
    Entry.new(full: "parm_up_cursor", short: "cuu"),
    Entry.new(full: "pkey_key", short: "pfkey"),
    Entry.new(full: "pkey_local", short: "pfloc"),
    Entry.new(full: "pkey_xmit", short: "pfx"),
    Entry.new(full: "print_screen", short: "mc0"),
    Entry.new(full: "prtr_off", short: "mc4"),
    Entry.new(full: "prtr_on", short: "mc5"),
    Entry.new(full: "repeat_char", short: "rep"),
    Entry.new(full: "reset_1string", short: "rs1"),
    Entry.new(full: "reset_2string", short: "rs2"),
    Entry.new(full: "reset_3string", short: "rs3"),
    Entry.new(full: "reset_file", short: "rf"),
    Entry.new(full: "restore_cursor", short: "rc"),
    Entry.new(full: "row_address", short: "vpa"),
    Entry.new(full: "save_cursor", short: "sc"),
    Entry.new(full: "scroll_forward", short: "ind"),
    Entry.new(full: "scroll_reverse", short: "ri"),
    Entry.new(full: "set_attributes", short: "sgr"),
    Entry.new(full: "set_tab", short: "hts"),
    Entry.new(full: "set_window", short: "wind"),
    Entry.new(full: "tab", short: "ht"),
    Entry.new(full: "to_status_line", short: "tsl"),
    Entry.new(full: "underline_char", short: "uc"),
    Entry.new(full: "up_half_line", short: "hu"),
    Entry.new(full: "init_prog", short: "iprog"),
    Entry.new(full: "key_a1", short: "ka1"),
    Entry.new(full: "key_a3", short: "ka3"),
    Entry.new(full: "key_b2", short: "kb2"),
    Entry.new(full: "key_c1", short: "kc1"),
    Entry.new(full: "key_c3", short: "kc3"),
    Entry.new(full: "prtr_non", short: "mc5p"),
    Entry.new(full: "char_padding", short: "rmp"),
    Entry.new(full: "acs_chars", short: "acsc"),
    Entry.new(full: "plab_norm", short: "pln"),
    Entry.new(full: "key_btab", short: "kcbt"),
    Entry.new(full: "enter_xon_mode", short: "smxon"),
    Entry.new(full: "exit_xon_mode", short: "rmxon"),
    Entry.new(full: "enter_am_mode", short: "smam"),
    Entry.new(full: "exit_am_mode", short: "rmam"),
    Entry.new(full: "xon_character", short: "xonc"),
    Entry.new(full: "xoff_character", short: "xoffc"),
    Entry.new(full: "ena_acs", short: "enacs"),
    Entry.new(full: "label_on", short: "smln"),
    Entry.new(full: "label_off", short: "rmln"),
    Entry.new(full: "key_beg", short: "kbeg"),
    Entry.new(full: "key_cancel", short: "kcan"),
    Entry.new(full: "key_close", short: "kclo"),
    Entry.new(full: "key_command", short: "kcmd"),
    Entry.new(full: "key_copy", short: "kcpy"),
    Entry.new(full: "key_create", short: "kcrt"),
    Entry.new(full: "key_end", short: "kend"),
    Entry.new(full: "key_enter", short: "kent"),
    Entry.new(full: "key_exit", short: "kext"),
    Entry.new(full: "key_find", short: "kfnd"),
    Entry.new(full: "key_help", short: "khlp"),
    Entry.new(full: "key_mark", short: "kmrk"),
    Entry.new(full: "key_message", short: "kmsg"),
    Entry.new(full: "key_move", short: "kmov"),
    Entry.new(full: "key_next", short: "knxt"),
    Entry.new(full: "key_open", short: "kopn"),
    Entry.new(full: "key_options", short: "kopt"),
    Entry.new(full: "key_previous", short: "kprv"),
    Entry.new(full: "key_print", short: "kprt"),
    Entry.new(full: "key_redo", short: "krdo"),
    Entry.new(full: "key_reference", short: "kref"),
    Entry.new(full: "key_refresh", short: "krfr"),
    Entry.new(full: "key_replace", short: "krpl"),
    Entry.new(full: "key_restart", short: "krst"),
    Entry.new(full: "key_resume", short: "kres"),
    Entry.new(full: "key_save", short: "ksav"),
    Entry.new(full: "key_suspend", short: "kspd"),
    Entry.new(full: "key_undo", short: "kund"),
    Entry.new(full: "key_sbeg", short: "kBEG"),
    Entry.new(full: "key_scancel", short: "kCAN"),
    Entry.new(full: "key_scommand", short: "kCMD"),
    Entry.new(full: "key_scopy", short: "kCPY"),
    Entry.new(full: "key_screate", short: "kCRT"),
    Entry.new(full: "key_sdc", short: "kDC"),
    Entry.new(full: "key_sdl", short: "kDL"),
    Entry.new(full: "key_select", short: "kslt"),
    Entry.new(full: "key_send", short: "kEND"),
    Entry.new(full: "key_seol", short: "kEOL"),
    Entry.new(full: "key_sexit", short: "kEXT"),
    Entry.new(full: "key_sfind", short: "kFND"),
    Entry.new(full: "key_shelp", short: "kHLP"),
    Entry.new(full: "key_shome", short: "kHOM"),
    Entry.new(full: "key_sic", short: "kIC"),
    Entry.new(full: "key_sleft", short: "kLFT"),
    Entry.new(full: "key_smessage", short: "kMSG"),
    Entry.new(full: "key_smove", short: "kMOV"),
    Entry.new(full: "key_snext", short: "kNXT"),
    Entry.new(full: "key_soptions", short: "kOPT"),
    Entry.new(full: "key_sprevious", short: "kPRV"),
    Entry.new(full: "key_sprint", short: "kPRT"),
    Entry.new(full: "key_sredo", short: "kRDO"),
    Entry.new(full: "key_sreplace", short: "kRPL"),
    Entry.new(full: "key_sright", short: "kRIT"),
    Entry.new(full: "key_srsume", short: "kRES"),
    Entry.new(full: "key_ssave", short: "kSAV"),
    Entry.new(full: "key_ssuspend", short: "kSPD"),
    Entry.new(full: "key_sundo", short: "kUND"),
    Entry.new(full: "req_for_input", short: "rfi"),
    Entry.new(full: "key_f11", short: "kf11"),
    Entry.new(full: "key_f12", short: "kf12"),
    Entry.new(full: "key_f13", short: "kf13"),
    Entry.new(full: "key_f14", short: "kf14"),
    Entry.new(full: "key_f15", short: "kf15"),
    Entry.new(full: "key_f16", short: "kf16"),
    Entry.new(full: "key_f17", short: "kf17"),
    Entry.new(full: "key_f18", short: "kf18"),
    Entry.new(full: "key_f19", short: "kf19"),
    Entry.new(full: "key_f20", short: "kf20"),
    Entry.new(full: "key_f21", short: "kf21"),
    Entry.new(full: "key_f22", short: "kf22"),
    Entry.new(full: "key_f23", short: "kf23"),
    Entry.new(full: "key_f24", short: "kf24"),
    Entry.new(full: "key_f25", short: "kf25"),
    Entry.new(full: "key_f26", short: "kf26"),
    Entry.new(full: "key_f27", short: "kf27"),
    Entry.new(full: "key_f28", short: "kf28"),
    Entry.new(full: "key_f29", short: "kf29"),
    Entry.new(full: "key_f30", short: "kf30"),
    Entry.new(full: "key_f31", short: "kf31"),
    Entry.new(full: "key_f32", short: "kf32"),
    Entry.new(full: "key_f33", short: "kf33"),
    Entry.new(full: "key_f34", short: "kf34"),
    Entry.new(full: "key_f35", short: "kf35"),
    Entry.new(full: "key_f36", short: "kf36"),
    Entry.new(full: "key_f37", short: "kf37"),
    Entry.new(full: "key_f38", short: "kf38"),
    Entry.new(full: "key_f39", short: "kf39"),
    Entry.new(full: "key_f40", short: "kf40"),
    Entry.new(full: "key_f41", short: "kf41"),
    Entry.new(full: "key_f42", short: "kf42"),
    Entry.new(full: "key_f43", short: "kf43"),
    Entry.new(full: "key_f44", short: "kf44"),
    Entry.new(full: "key_f45", short: "kf45"),
    Entry.new(full: "key_f46", short: "kf46"),
    Entry.new(full: "key_f47", short: "kf47"),
    Entry.new(full: "key_f48", short: "kf48"),
    Entry.new(full: "key_f49", short: "kf49"),
    Entry.new(full: "key_f50", short: "kf50"),
    Entry.new(full: "key_f51", short: "kf51"),
    Entry.new(full: "key_f52", short: "kf52"),
    Entry.new(full: "key_f53", short: "kf53"),
    Entry.new(full: "key_f54", short: "kf54"),
    Entry.new(full: "key_f55", short: "kf55"),
    Entry.new(full: "key_f56", short: "kf56"),
    Entry.new(full: "key_f57", short: "kf57"),
    Entry.new(full: "key_f58", short: "kf58"),
    Entry.new(full: "key_f59", short: "kf59"),
    Entry.new(full: "key_f60", short: "kf60"),
    Entry.new(full: "key_f61", short: "kf61"),
    Entry.new(full: "key_f62", short: "kf62"),
    Entry.new(full: "key_f63", short: "kf63"),
    Entry.new(full: "clr_bol", short: "el1"),
    Entry.new(full: "clear_margins", short: "mgc"),
    Entry.new(full: "set_left_margin", short: "smgl"),
    Entry.new(full: "set_right_margin", short: "smgr"),
    Entry.new(full: "label_format", short: "fln"),
    Entry.new(full: "set_clock", short: "sclk"),
    Entry.new(full: "display_clock", short: "dclk"),
    Entry.new(full: "remove_clock", short: "rmclk"),
    Entry.new(full: "create_window", short: "cwin"),
    Entry.new(full: "goto_window", short: "wingo"),
    Entry.new(full: "hangup", short: "hup"),
    Entry.new(full: "dial_phone", short: "dial"),
    Entry.new(full: "quick_dial", short: "qdial"),
    Entry.new(full: "tone", short: "tone"),
    Entry.new(full: "pulse", short: "pulse"),
    Entry.new(full: "flash_hook", short: "hook"),
    Entry.new(full: "fixed_pause", short: "pause"),
    Entry.new(full: "wait_tone", short: "wait"),
    Entry.new(full: "user0", short: "u0"),
    Entry.new(full: "user1", short: "u1"),
    Entry.new(full: "user2", short: "u2"),
    Entry.new(full: "user3", short: "u3"),
    Entry.new(full: "user4", short: "u4"),
    Entry.new(full: "user5", short: "u5"),
    Entry.new(full: "user6", short: "u6"),
    Entry.new(full: "user7", short: "u7"),
    Entry.new(full: "user8", short: "u8"),
    Entry.new(full: "user9", short: "u9"),
    Entry.new(full: "orig_pair", short: "op"),
    Entry.new(full: "orig_colors", short: "oc"),
    Entry.new(full: "initialize_color", short: "initc"),
    Entry.new(full: "initialize_pair", short: "initp"),
    Entry.new(full: "set_color_pair", short: "scp"),
    Entry.new(full: "set_foreground", short: "setf"),
    Entry.new(full: "set_background", short: "setb"),
    Entry.new(full: "change_char_pitch", short: "cpi"),
    Entry.new(full: "change_line_pitch", short: "lpi"),
    Entry.new(full: "change_res_horz", short: "chr"),
    Entry.new(full: "change_res_vert", short: "cvr"),
    Entry.new(full: "define_char", short: "defc"),
    Entry.new(full: "enter_doublewide_mode", short: "swidm"),
    Entry.new(full: "enter_draft_quality", short: "sdrfq"),
    Entry.new(full: "enter_italics_mode", short: "sitm"),
    Entry.new(full: "enter_leftward_mode", short: "slm"),
    Entry.new(full: "enter_micro_mode", short: "smicm"),
    Entry.new(full: "enter_near_letter_quality", short: "snlq"),
    Entry.new(full: "enter_normal_quality", short: "snrmq"),
    Entry.new(full: "enter_shadow_mode", short: "sshm"),
    Entry.new(full: "enter_subscript_mode", short: "ssubm"),
    Entry.new(full: "enter_superscript_mode", short: "ssupm"),
    Entry.new(full: "enter_upward_mode", short: "sum"),
    Entry.new(full: "exit_doublewide_mode", short: "rwidm"),
    Entry.new(full: "exit_italics_mode", short: "ritm"),
    Entry.new(full: "exit_leftward_mode", short: "rlm"),
    Entry.new(full: "exit_micro_mode", short: "rmicm"),
    Entry.new(full: "exit_shadow_mode", short: "rshm"),
    Entry.new(full: "exit_subscript_mode", short: "rsubm"),
    Entry.new(full: "exit_superscript_mode", short: "rsupm"),
    Entry.new(full: "exit_upward_mode", short: "rum"),
    Entry.new(full: "micro_column_address", short: "mhpa"),
    Entry.new(full: "micro_down", short: "mcud1"),
    Entry.new(full: "micro_left", short: "mcub1"),
    Entry.new(full: "micro_right", short: "mcuf1"),
    Entry.new(full: "micro_row_address", short: "mvpa"),
    Entry.new(full: "micro_up", short: "mcuu1"),
    Entry.new(full: "order_of_pins", short: "porder"),
    Entry.new(full: "parm_down_micro", short: "mcud"),
    Entry.new(full: "parm_left_micro", short: "mcub"),
    Entry.new(full: "parm_right_micro", short: "mcuf"),
    Entry.new(full: "parm_up_micro", short: "mcuu"),
    Entry.new(full: "select_char_set", short: "scs"),
    Entry.new(full: "set_bottom_margin", short: "smgb"),
    Entry.new(full: "set_bottom_margin_parm", short: "smgbp"),
    Entry.new(full: "set_left_margin_parm", short: "smglp"),
    Entry.new(full: "set_right_margin_parm", short: "smgrp"),
    Entry.new(full: "set_top_margin", short: "smgt"),
    Entry.new(full: "set_top_margin_parm", short: "smgtp"),
    Entry.new(full: "start_bit_image", short: "sbim"),
    Entry.new(full: "start_char_set_def", short: "scsd"),
    Entry.new(full: "stop_bit_image", short: "rbim"),
    Entry.new(full: "stop_char_set_def", short: "rcsd"),
    Entry.new(full: "subscript_characters", short: "subcs"),
    Entry.new(full: "superscript_characters", short: "supcs"),
    Entry.new(full: "these_cause_cr", short: "docr"),
    Entry.new(full: "zero_motion", short: "zerom"),
    Entry.new(full: "char_set_names", short: "csnm"),
    Entry.new(full: "key_mouse", short: "kmous"),
    Entry.new(full: "mouse_info", short: "minfo"),
    Entry.new(full: "req_mouse_pos", short: "reqmp"),
    Entry.new(full: "get_mouse", short: "getm"),
    Entry.new(full: "set_a_foreground", short: "setaf"),
    Entry.new(full: "set_a_background", short: "setab"),
    Entry.new(full: "pkey_plab", short: "pfxl"),
    Entry.new(full: "device_type", short: "devt"),
    Entry.new(full: "code_set_init", short: "csin"),
    Entry.new(full: "set0_des_seq", short: "s0ds"),
    Entry.new(full: "set1_des_seq", short: "s1ds"),
    Entry.new(full: "set2_des_seq", short: "s2ds"),
    Entry.new(full: "set3_des_seq", short: "s3ds"),
    Entry.new(full: "set_lr_margin", short: "smglr"),
    Entry.new(full: "set_tb_margin", short: "smgtb"),
    Entry.new(full: "bit_image_repeat", short: "birep"),
    Entry.new(full: "bit_image_newline", short: "binel"),
    Entry.new(full: "bit_image_carriage_return", short: "bicr"),
    Entry.new(full: "color_names", short: "colornm"),
    Entry.new(full: "define_bit_image_region", short: "defbi"),
    Entry.new(full: "end_bit_image_region", short: "endbi"),
    Entry.new(full: "set_color_band", short: "setcolor"),
    Entry.new(full: "set_page_length", short: "slines"),
    Entry.new(full: "display_pc_char", short: "dispc"),
    Entry.new(full: "enter_pc_charset_mode", short: "smpch"),
    Entry.new(full: "exit_pc_charset_mode", short: "rmpch"),
    Entry.new(full: "enter_scancode_mode", short: "smsc"),
    Entry.new(full: "exit_scancode_mode", short: "rmsc"),
    Entry.new(full: "pc_term_options", short: "pctrm"),
    Entry.new(full: "scancode_escape", short: "scesc"),
    Entry.new(full: "alt_scancode_esc", short: "scesa"),
    Entry.new(full: "enter_horizontal_hl_mode", short: "ehhlm"),
    Entry.new(full: "enter_left_hl_mode", short: "elhlm"),
    Entry.new(full: "enter_low_hl_mode", short: "elohlm"),
    Entry.new(full: "enter_right_hl_mode", short: "erhlm"),
    Entry.new(full: "enter_top_hl_mode", short: "ethlm"),
    Entry.new(full: "enter_vertical_hl_mode", short: "evhlm"),
    Entry.new(full: "set_a_attributes", short: "sgr1"),
    Entry.new(full: "set_pglen_inch", short: "slength"),
    Entry.new(full: "termcap_init2", short: "OTi2"),
    Entry.new(full: "termcap_reset", short: "OTrs"),
    Entry.new(full: "linefeed_if_not_lf", short: "OTnl"),
    Entry.new(full: "backspace_if_not_bs", short: "OTbs"),
    Entry.new(full: "other_non_function_keys", short: "OTko"),
    Entry.new(full: "arrow_key_map", short: "OTma"),
    Entry.new(full: "acs_ulcorner", short: "OTG2"),
    Entry.new(full: "acs_llcorner", short: "OTG3"),
    Entry.new(full: "acs_urcorner", short: "OTG1"),
    Entry.new(full: "acs_lrcorner", short: "OTG4"),
    Entry.new(full: "acs_ltee", short: "OTGR"),
    Entry.new(full: "acs_rtee", short: "OTGL"),
    Entry.new(full: "acs_btee", short: "OTGU"),
    Entry.new(full: "acs_ttee", short: "OTGD"),
    Entry.new(full: "acs_hline", short: "OTGH"),
    Entry.new(full: "acs_vline", short: "OTGV"),
    Entry.new(full: "acs_plus", short: "OTGC"),
    Entry.new(full: "memory_lock", short: "meml"),
    Entry.new(full: "memory_unlock", short: "memu"),
    Entry.new(full: "box_chars_1", short: "box1"),
  ]
end
