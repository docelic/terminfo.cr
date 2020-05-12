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

# FIXME: 'keys' is not the right terminology for these...
# man terminfo uses 'capability', let's use that! (or 'caps' for short?)
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

    # FIXME: what about having the info here only and not in KeyNames ?
    #        this would solve easily going from Cr's enum to cap long/short
    #        name but not the other way around....

    def short_name
      KeyNames::Booleans[value].short
    end

    def long_name
      KeyNames::Booleans[value].long
    end
  end

  # FIXME: man terminfo uses 'numeric' (-> 'numeric capability')
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

    def short_name
      KeyNames::Numbers[value].short
    end

    def long_name
      KeyNames::Numbers[value].long
    end
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

    def short_name
      KeyNames::Strings[value].short
    end

    def long_name
      KeyNames::Strings[value].long
    end
  end
end

# FIXME: use 'capability' terminology instead of 'key'
module Terminfo::KeyNames
  record Entry, long : String, short : String do
    def to_s(io)
      @long
    end
  end

  Booleans = [
    # Order is important (TODO: explain why)
    # short explanation: so we can target a specific entry by the capability
    # enum value which is an index in these tables.

    Entry.new(long: "auto_left_margin", short: "bw"),
    Entry.new(long: "auto_right_margin", short: "am"),
    Entry.new(long: "no_esc_ctlc", short: "xsb"),
    Entry.new(long: "ceol_standout_glitch", short: "xhp"),
    Entry.new(long: "eat_newline_glitch", short: "xenl"),
    Entry.new(long: "erase_overstrike", short: "eo"),
    Entry.new(long: "generic_type", short: "gn"),
    Entry.new(long: "hard_copy", short: "hc"),
    Entry.new(long: "has_meta_key", short: "km"),
    Entry.new(long: "has_status_line", short: "hs"),
    Entry.new(long: "insert_null_glitch", short: "in"),
    Entry.new(long: "memory_above", short: "db"),
    Entry.new(long: "memory_below", short: "da"),
    Entry.new(long: "move_insert_mode", short: "mir"),
    Entry.new(long: "move_standout_mode", short: "msgr"),
    Entry.new(long: "over_strike", short: "os"),
    Entry.new(long: "status_line_esc_ok", short: "eslok"),
    Entry.new(long: "dest_tabs_magic_smso", short: "xt"),
    Entry.new(long: "tilde_glitch", short: "hz"),
    Entry.new(long: "transparent_underline", short: "ul"),
    Entry.new(long: "xon_xoff", short: "xon"),
    Entry.new(long: "needs_xon_xoff", short: "nxon"),
    Entry.new(long: "prtr_silent", short: "mc5i"),
    Entry.new(long: "hard_cursor", short: "chts"),
    Entry.new(long: "non_rev_rmcup", short: "nrrmc"),
    Entry.new(long: "no_pad_char", short: "npc"),
    Entry.new(long: "non_dest_scroll_region", short: "ndscr"),
    Entry.new(long: "can_change", short: "ccc"),
    Entry.new(long: "back_color_erase", short: "bce"),
    Entry.new(long: "hue_lightness_saturation", short: "hls"),
    Entry.new(long: "col_addr_glitch", short: "xhpa"),
    Entry.new(long: "cr_cancels_micro_mode", short: "crxm"),
    Entry.new(long: "has_print_wheel", short: "daisy"),
    Entry.new(long: "row_addr_glitch", short: "xvpa"),
    Entry.new(long: "semi_auto_right_margin", short: "sam"),
    Entry.new(long: "cpi_changes_res", short: "cpix"),
    Entry.new(long: "lpi_changes_res", short: "lpix"),
    Entry.new(long: "backspaces_with_bs", short: "OTbs"),
    Entry.new(long: "crt_no_scrolling", short: "OTns"),
    Entry.new(long: "no_correctly_working_cr", short: "OTnc"),
    Entry.new(long: "gnu_has_meta_key", short: "OTMT"),
    Entry.new(long: "linefeed_is_newline", short: "OTNL"),
    Entry.new(long: "has_hardware_tabs", short: "OTpt"),
    Entry.new(long: "return_does_clr_eol", short: "OTxr"),
  ]

  Numbers = [
    # Order is important

    Entry.new(long: "columns", short: "cols"),
    Entry.new(long: "init_tabs", short: "it"),
    Entry.new(long: "lines", short: "lines"),
    Entry.new(long: "lines_of_memory", short: "lm"),
    Entry.new(long: "magic_cookie_glitch", short: "xmc"),
    Entry.new(long: "padding_baud_rate", short: "pb"),
    Entry.new(long: "virtual_terminal", short: "vt"),
    Entry.new(long: "width_status_line", short: "wsl"),
    Entry.new(long: "num_labels", short: "nlab"),
    Entry.new(long: "label_height", short: "lh"),
    Entry.new(long: "label_width", short: "lw"),
    Entry.new(long: "max_attributes", short: "ma"),
    Entry.new(long: "maximum_windows", short: "wnum"),
    Entry.new(long: "max_colors", short: "colors"),
    Entry.new(long: "max_pairs", short: "pairs"),
    Entry.new(long: "no_color_video", short: "ncv"),
    Entry.new(long: "buffer_capacity", short: "bufsz"),
    Entry.new(long: "dot_vert_spacing", short: "spinv"),
    Entry.new(long: "dot_horz_spacing", short: "spinh"),
    Entry.new(long: "max_micro_address", short: "maddr"),
    Entry.new(long: "max_micro_jump", short: "mjump"),
    Entry.new(long: "micro_col_size", short: "mcs"),
    Entry.new(long: "micro_line_size", short: "mls"),
    Entry.new(long: "number_of_pins", short: "npins"),
    Entry.new(long: "output_res_char", short: "orc"),
    Entry.new(long: "output_res_line", short: "orl"),
    Entry.new(long: "output_res_horz_inch", short: "orhi"),
    Entry.new(long: "output_res_vert_inch", short: "orvi"),
    Entry.new(long: "print_rate", short: "cps"),
    Entry.new(long: "wide_char_size", short: "widcs"),
    Entry.new(long: "buttons", short: "btns"),
    Entry.new(long: "bit_image_entwining", short: "bitwin"),
    Entry.new(long: "bit_image_type", short: "bitype"),
    Entry.new(long: "magic_cookie_glitch_ul", short: "UTug"),
    Entry.new(long: "carriage_return_delay", short: "OTdC"),
    Entry.new(long: "new_line_delay", short: "OTdN"),
    Entry.new(long: "backspace_delay", short: "OTdB"),
    Entry.new(long: "horizontal_tab_delay", short: "OTdT"),
    Entry.new(long: "number_of_function_keys", short: "OTkn"),
  ]

  Strings = [
    # Order is important

    Entry.new(long: "back_tab", short: "cbt"),
    Entry.new(long: "bell", short: "bel"),
    Entry.new(long: "carriage_return", short: "cr"),
    Entry.new(long: "change_scroll_region", short: "csr"),
    Entry.new(long: "clear_all_tabs", short: "tbc"),
    Entry.new(long: "clear_screen", short: "clear"),
    Entry.new(long: "clr_eol", short: "el"),
    Entry.new(long: "clr_eos", short: "ed"),
    Entry.new(long: "column_address", short: "hpa"),
    Entry.new(long: "command_character", short: "cmdch"),
    Entry.new(long: "cursor_address", short: "cup"),
    Entry.new(long: "cursor_down", short: "cud1"),
    Entry.new(long: "cursor_home", short: "home"),
    Entry.new(long: "cursor_invisible", short: "civis"),
    Entry.new(long: "cursor_left", short: "cub1"),
    Entry.new(long: "cursor_mem_address", short: "mrcup"),
    Entry.new(long: "cursor_normal", short: "cnorm"),
    Entry.new(long: "cursor_right", short: "cuf1"),
    Entry.new(long: "cursor_to_ll", short: "ll"),
    Entry.new(long: "cursor_up", short: "cuu1"),
    Entry.new(long: "cursor_visible", short: "cvvis"),
    Entry.new(long: "delete_character", short: "dch1"),
    Entry.new(long: "delete_line", short: "dl1"),
    Entry.new(long: "dis_status_line", short: "dsl"),
    Entry.new(long: "down_half_line", short: "hd"),
    Entry.new(long: "enter_alt_charset_mode", short: "smacs"),
    Entry.new(long: "enter_blink_mode", short: "blink"),
    Entry.new(long: "enter_bold_mode", short: "bold"),
    Entry.new(long: "enter_ca_mode", short: "smcup"),
    Entry.new(long: "enter_delete_mode", short: "smdc"),
    Entry.new(long: "enter_dim_mode", short: "dim"),
    Entry.new(long: "enter_insert_mode", short: "smir"),
    Entry.new(long: "enter_secure_mode", short: "invis"),
    Entry.new(long: "enter_protected_mode", short: "prot"),
    Entry.new(long: "enter_reverse_mode", short: "rev"),
    Entry.new(long: "enter_standout_mode", short: "smso"),
    Entry.new(long: "enter_underline_mode", short: "smul"),
    Entry.new(long: "erase_chars", short: "ech"),
    Entry.new(long: "exit_alt_charset_mode", short: "rmacs"),
    Entry.new(long: "exit_attribute_mode", short: "sgr0"),
    Entry.new(long: "exit_ca_mode", short: "rmcup"),
    Entry.new(long: "exit_delete_mode", short: "rmdc"),
    Entry.new(long: "exit_insert_mode", short: "rmir"),
    Entry.new(long: "exit_standout_mode", short: "rmso"),
    Entry.new(long: "exit_underline_mode", short: "rmul"),
    Entry.new(long: "flash_screen", short: "flash"),
    Entry.new(long: "form_feed", short: "ff"),
    Entry.new(long: "from_status_line", short: "fsl"),
    Entry.new(long: "init_1string", short: "is1"),
    Entry.new(long: "init_2string", short: "is2"),
    Entry.new(long: "init_3string", short: "is3"),
    Entry.new(long: "init_file", short: "if"),
    Entry.new(long: "insert_character", short: "ich1"),
    Entry.new(long: "insert_line", short: "il1"),
    Entry.new(long: "insert_padding", short: "ip"),
    Entry.new(long: "key_backspace", short: "kbs"),
    Entry.new(long: "key_catab", short: "ktbc"),
    Entry.new(long: "key_clear", short: "kclr"),
    Entry.new(long: "key_ctab", short: "kctab"),
    Entry.new(long: "key_dc", short: "kdch1"),
    Entry.new(long: "key_dl", short: "kdl1"),
    Entry.new(long: "key_down", short: "kcud1"),
    Entry.new(long: "key_eic", short: "krmir"),
    Entry.new(long: "key_eol", short: "kel"),
    Entry.new(long: "key_eos", short: "ked"),
    Entry.new(long: "key_f0", short: "kf0"),
    Entry.new(long: "key_f1", short: "kf1"),
    Entry.new(long: "key_f10", short: "kf10"),
    Entry.new(long: "key_f2", short: "kf2"),
    Entry.new(long: "key_f3", short: "kf3"),
    Entry.new(long: "key_f4", short: "kf4"),
    Entry.new(long: "key_f5", short: "kf5"),
    Entry.new(long: "key_f6", short: "kf6"),
    Entry.new(long: "key_f7", short: "kf7"),
    Entry.new(long: "key_f8", short: "kf8"),
    Entry.new(long: "key_f9", short: "kf9"),
    Entry.new(long: "key_home", short: "khome"),
    Entry.new(long: "key_ic", short: "kich1"),
    Entry.new(long: "key_il", short: "kil1"),
    Entry.new(long: "key_left", short: "kcub1"),
    Entry.new(long: "key_ll", short: "kll"),
    Entry.new(long: "key_npage", short: "knp"),
    Entry.new(long: "key_ppage", short: "kpp"),
    Entry.new(long: "key_right", short: "kcuf1"),
    Entry.new(long: "key_sf", short: "kind"),
    Entry.new(long: "key_sr", short: "kri"),
    Entry.new(long: "key_stab", short: "khts"),
    Entry.new(long: "key_up", short: "kcuu1"),
    Entry.new(long: "keypad_local", short: "rmkx"),
    Entry.new(long: "keypad_xmit", short: "smkx"),
    Entry.new(long: "lab_f0", short: "lf0"),
    Entry.new(long: "lab_f1", short: "lf1"),
    Entry.new(long: "lab_f10", short: "lf10"),
    Entry.new(long: "lab_f2", short: "lf2"),
    Entry.new(long: "lab_f3", short: "lf3"),
    Entry.new(long: "lab_f4", short: "lf4"),
    Entry.new(long: "lab_f5", short: "lf5"),
    Entry.new(long: "lab_f6", short: "lf6"),
    Entry.new(long: "lab_f7", short: "lf7"),
    Entry.new(long: "lab_f8", short: "lf8"),
    Entry.new(long: "lab_f9", short: "lf9"),
    Entry.new(long: "meta_off", short: "rmm"),
    Entry.new(long: "meta_on", short: "smm"),
    Entry.new(long: "newline", short: "nel"),
    Entry.new(long: "pad_char", short: "pad"),
    Entry.new(long: "parm_dch", short: "dch"),
    Entry.new(long: "parm_delete_line", short: "dl"),
    Entry.new(long: "parm_down_cursor", short: "cud"),
    Entry.new(long: "parm_ich", short: "ich"),
    Entry.new(long: "parm_index", short: "indn"),
    Entry.new(long: "parm_insert_line", short: "il"),
    Entry.new(long: "parm_left_cursor", short: "cub"),
    Entry.new(long: "parm_right_cursor", short: "cuf"),
    Entry.new(long: "parm_rindex", short: "rin"),
    Entry.new(long: "parm_up_cursor", short: "cuu"),
    Entry.new(long: "pkey_key", short: "pfkey"),
    Entry.new(long: "pkey_local", short: "pfloc"),
    Entry.new(long: "pkey_xmit", short: "pfx"),
    Entry.new(long: "print_screen", short: "mc0"),
    Entry.new(long: "prtr_off", short: "mc4"),
    Entry.new(long: "prtr_on", short: "mc5"),
    Entry.new(long: "repeat_char", short: "rep"),
    Entry.new(long: "reset_1string", short: "rs1"),
    Entry.new(long: "reset_2string", short: "rs2"),
    Entry.new(long: "reset_3string", short: "rs3"),
    Entry.new(long: "reset_file", short: "rf"),
    Entry.new(long: "restore_cursor", short: "rc"),
    Entry.new(long: "row_address", short: "vpa"),
    Entry.new(long: "save_cursor", short: "sc"),
    Entry.new(long: "scroll_forward", short: "ind"),
    Entry.new(long: "scroll_reverse", short: "ri"),
    Entry.new(long: "set_attributes", short: "sgr"),
    Entry.new(long: "set_tab", short: "hts"),
    Entry.new(long: "set_window", short: "wind"),
    Entry.new(long: "tab", short: "ht"),
    Entry.new(long: "to_status_line", short: "tsl"),
    Entry.new(long: "underline_char", short: "uc"),
    Entry.new(long: "up_half_line", short: "hu"),
    Entry.new(long: "init_prog", short: "iprog"),
    Entry.new(long: "key_a1", short: "ka1"),
    Entry.new(long: "key_a3", short: "ka3"),
    Entry.new(long: "key_b2", short: "kb2"),
    Entry.new(long: "key_c1", short: "kc1"),
    Entry.new(long: "key_c3", short: "kc3"),
    Entry.new(long: "prtr_non", short: "mc5p"),
    Entry.new(long: "char_padding", short: "rmp"),
    Entry.new(long: "acs_chars", short: "acsc"),
    Entry.new(long: "plab_norm", short: "pln"),
    Entry.new(long: "key_btab", short: "kcbt"),
    Entry.new(long: "enter_xon_mode", short: "smxon"),
    Entry.new(long: "exit_xon_mode", short: "rmxon"),
    Entry.new(long: "enter_am_mode", short: "smam"),
    Entry.new(long: "exit_am_mode", short: "rmam"),
    Entry.new(long: "xon_character", short: "xonc"),
    Entry.new(long: "xoff_character", short: "xoffc"),
    Entry.new(long: "ena_acs", short: "enacs"),
    Entry.new(long: "label_on", short: "smln"),
    Entry.new(long: "label_off", short: "rmln"),
    Entry.new(long: "key_beg", short: "kbeg"),
    Entry.new(long: "key_cancel", short: "kcan"),
    Entry.new(long: "key_close", short: "kclo"),
    Entry.new(long: "key_command", short: "kcmd"),
    Entry.new(long: "key_copy", short: "kcpy"),
    Entry.new(long: "key_create", short: "kcrt"),
    Entry.new(long: "key_end", short: "kend"),
    Entry.new(long: "key_enter", short: "kent"),
    Entry.new(long: "key_exit", short: "kext"),
    Entry.new(long: "key_find", short: "kfnd"),
    Entry.new(long: "key_help", short: "khlp"),
    Entry.new(long: "key_mark", short: "kmrk"),
    Entry.new(long: "key_message", short: "kmsg"),
    Entry.new(long: "key_move", short: "kmov"),
    Entry.new(long: "key_next", short: "knxt"),
    Entry.new(long: "key_open", short: "kopn"),
    Entry.new(long: "key_options", short: "kopt"),
    Entry.new(long: "key_previous", short: "kprv"),
    Entry.new(long: "key_print", short: "kprt"),
    Entry.new(long: "key_redo", short: "krdo"),
    Entry.new(long: "key_reference", short: "kref"),
    Entry.new(long: "key_refresh", short: "krfr"),
    Entry.new(long: "key_replace", short: "krpl"),
    Entry.new(long: "key_restart", short: "krst"),
    Entry.new(long: "key_resume", short: "kres"),
    Entry.new(long: "key_save", short: "ksav"),
    Entry.new(long: "key_suspend", short: "kspd"),
    Entry.new(long: "key_undo", short: "kund"),
    Entry.new(long: "key_sbeg", short: "kBEG"),
    Entry.new(long: "key_scancel", short: "kCAN"),
    Entry.new(long: "key_scommand", short: "kCMD"),
    Entry.new(long: "key_scopy", short: "kCPY"),
    Entry.new(long: "key_screate", short: "kCRT"),
    Entry.new(long: "key_sdc", short: "kDC"),
    Entry.new(long: "key_sdl", short: "kDL"),
    Entry.new(long: "key_select", short: "kslt"),
    Entry.new(long: "key_send", short: "kEND"),
    Entry.new(long: "key_seol", short: "kEOL"),
    Entry.new(long: "key_sexit", short: "kEXT"),
    Entry.new(long: "key_sfind", short: "kFND"),
    Entry.new(long: "key_shelp", short: "kHLP"),
    Entry.new(long: "key_shome", short: "kHOM"),
    Entry.new(long: "key_sic", short: "kIC"),
    Entry.new(long: "key_sleft", short: "kLFT"),
    Entry.new(long: "key_smessage", short: "kMSG"),
    Entry.new(long: "key_smove", short: "kMOV"),
    Entry.new(long: "key_snext", short: "kNXT"),
    Entry.new(long: "key_soptions", short: "kOPT"),
    Entry.new(long: "key_sprevious", short: "kPRV"),
    Entry.new(long: "key_sprint", short: "kPRT"),
    Entry.new(long: "key_sredo", short: "kRDO"),
    Entry.new(long: "key_sreplace", short: "kRPL"),
    Entry.new(long: "key_sright", short: "kRIT"),
    Entry.new(long: "key_srsume", short: "kRES"),
    Entry.new(long: "key_ssave", short: "kSAV"),
    Entry.new(long: "key_ssuspend", short: "kSPD"),
    Entry.new(long: "key_sundo", short: "kUND"),
    Entry.new(long: "req_for_input", short: "rfi"),
    Entry.new(long: "key_f11", short: "kf11"),
    Entry.new(long: "key_f12", short: "kf12"),
    Entry.new(long: "key_f13", short: "kf13"),
    Entry.new(long: "key_f14", short: "kf14"),
    Entry.new(long: "key_f15", short: "kf15"),
    Entry.new(long: "key_f16", short: "kf16"),
    Entry.new(long: "key_f17", short: "kf17"),
    Entry.new(long: "key_f18", short: "kf18"),
    Entry.new(long: "key_f19", short: "kf19"),
    Entry.new(long: "key_f20", short: "kf20"),
    Entry.new(long: "key_f21", short: "kf21"),
    Entry.new(long: "key_f22", short: "kf22"),
    Entry.new(long: "key_f23", short: "kf23"),
    Entry.new(long: "key_f24", short: "kf24"),
    Entry.new(long: "key_f25", short: "kf25"),
    Entry.new(long: "key_f26", short: "kf26"),
    Entry.new(long: "key_f27", short: "kf27"),
    Entry.new(long: "key_f28", short: "kf28"),
    Entry.new(long: "key_f29", short: "kf29"),
    Entry.new(long: "key_f30", short: "kf30"),
    Entry.new(long: "key_f31", short: "kf31"),
    Entry.new(long: "key_f32", short: "kf32"),
    Entry.new(long: "key_f33", short: "kf33"),
    Entry.new(long: "key_f34", short: "kf34"),
    Entry.new(long: "key_f35", short: "kf35"),
    Entry.new(long: "key_f36", short: "kf36"),
    Entry.new(long: "key_f37", short: "kf37"),
    Entry.new(long: "key_f38", short: "kf38"),
    Entry.new(long: "key_f39", short: "kf39"),
    Entry.new(long: "key_f40", short: "kf40"),
    Entry.new(long: "key_f41", short: "kf41"),
    Entry.new(long: "key_f42", short: "kf42"),
    Entry.new(long: "key_f43", short: "kf43"),
    Entry.new(long: "key_f44", short: "kf44"),
    Entry.new(long: "key_f45", short: "kf45"),
    Entry.new(long: "key_f46", short: "kf46"),
    Entry.new(long: "key_f47", short: "kf47"),
    Entry.new(long: "key_f48", short: "kf48"),
    Entry.new(long: "key_f49", short: "kf49"),
    Entry.new(long: "key_f50", short: "kf50"),
    Entry.new(long: "key_f51", short: "kf51"),
    Entry.new(long: "key_f52", short: "kf52"),
    Entry.new(long: "key_f53", short: "kf53"),
    Entry.new(long: "key_f54", short: "kf54"),
    Entry.new(long: "key_f55", short: "kf55"),
    Entry.new(long: "key_f56", short: "kf56"),
    Entry.new(long: "key_f57", short: "kf57"),
    Entry.new(long: "key_f58", short: "kf58"),
    Entry.new(long: "key_f59", short: "kf59"),
    Entry.new(long: "key_f60", short: "kf60"),
    Entry.new(long: "key_f61", short: "kf61"),
    Entry.new(long: "key_f62", short: "kf62"),
    Entry.new(long: "key_f63", short: "kf63"),
    Entry.new(long: "clr_bol", short: "el1"),
    Entry.new(long: "clear_margins", short: "mgc"),
    Entry.new(long: "set_left_margin", short: "smgl"),
    Entry.new(long: "set_right_margin", short: "smgr"),
    Entry.new(long: "label_format", short: "fln"),
    Entry.new(long: "set_clock", short: "sclk"),
    Entry.new(long: "display_clock", short: "dclk"),
    Entry.new(long: "remove_clock", short: "rmclk"),
    Entry.new(long: "create_window", short: "cwin"),
    Entry.new(long: "goto_window", short: "wingo"),
    Entry.new(long: "hangup", short: "hup"),
    Entry.new(long: "dial_phone", short: "dial"),
    Entry.new(long: "quick_dial", short: "qdial"),
    Entry.new(long: "tone", short: "tone"),
    Entry.new(long: "pulse", short: "pulse"),
    Entry.new(long: "flash_hook", short: "hook"),
    Entry.new(long: "fixed_pause", short: "pause"),
    Entry.new(long: "wait_tone", short: "wait"),
    Entry.new(long: "user0", short: "u0"),
    Entry.new(long: "user1", short: "u1"),
    Entry.new(long: "user2", short: "u2"),
    Entry.new(long: "user3", short: "u3"),
    Entry.new(long: "user4", short: "u4"),
    Entry.new(long: "user5", short: "u5"),
    Entry.new(long: "user6", short: "u6"),
    Entry.new(long: "user7", short: "u7"),
    Entry.new(long: "user8", short: "u8"),
    Entry.new(long: "user9", short: "u9"),
    Entry.new(long: "orig_pair", short: "op"),
    Entry.new(long: "orig_colors", short: "oc"),
    Entry.new(long: "initialize_color", short: "initc"),
    Entry.new(long: "initialize_pair", short: "initp"),
    Entry.new(long: "set_color_pair", short: "scp"),
    Entry.new(long: "set_foreground", short: "setf"),
    Entry.new(long: "set_background", short: "setb"),
    Entry.new(long: "change_char_pitch", short: "cpi"),
    Entry.new(long: "change_line_pitch", short: "lpi"),
    Entry.new(long: "change_res_horz", short: "chr"),
    Entry.new(long: "change_res_vert", short: "cvr"),
    Entry.new(long: "define_char", short: "defc"),
    Entry.new(long: "enter_doublewide_mode", short: "swidm"),
    Entry.new(long: "enter_draft_quality", short: "sdrfq"),
    Entry.new(long: "enter_italics_mode", short: "sitm"),
    Entry.new(long: "enter_leftward_mode", short: "slm"),
    Entry.new(long: "enter_micro_mode", short: "smicm"),
    Entry.new(long: "enter_near_letter_quality", short: "snlq"),
    Entry.new(long: "enter_normal_quality", short: "snrmq"),
    Entry.new(long: "enter_shadow_mode", short: "sshm"),
    Entry.new(long: "enter_subscript_mode", short: "ssubm"),
    Entry.new(long: "enter_superscript_mode", short: "ssupm"),
    Entry.new(long: "enter_upward_mode", short: "sum"),
    Entry.new(long: "exit_doublewide_mode", short: "rwidm"),
    Entry.new(long: "exit_italics_mode", short: "ritm"),
    Entry.new(long: "exit_leftward_mode", short: "rlm"),
    Entry.new(long: "exit_micro_mode", short: "rmicm"),
    Entry.new(long: "exit_shadow_mode", short: "rshm"),
    Entry.new(long: "exit_subscript_mode", short: "rsubm"),
    Entry.new(long: "exit_superscript_mode", short: "rsupm"),
    Entry.new(long: "exit_upward_mode", short: "rum"),
    Entry.new(long: "micro_column_address", short: "mhpa"),
    Entry.new(long: "micro_down", short: "mcud1"),
    Entry.new(long: "micro_left", short: "mcub1"),
    Entry.new(long: "micro_right", short: "mcuf1"),
    Entry.new(long: "micro_row_address", short: "mvpa"),
    Entry.new(long: "micro_up", short: "mcuu1"),
    Entry.new(long: "order_of_pins", short: "porder"),
    Entry.new(long: "parm_down_micro", short: "mcud"),
    Entry.new(long: "parm_left_micro", short: "mcub"),
    Entry.new(long: "parm_right_micro", short: "mcuf"),
    Entry.new(long: "parm_up_micro", short: "mcuu"),
    Entry.new(long: "select_char_set", short: "scs"),
    Entry.new(long: "set_bottom_margin", short: "smgb"),
    Entry.new(long: "set_bottom_margin_parm", short: "smgbp"),
    Entry.new(long: "set_left_margin_parm", short: "smglp"),
    Entry.new(long: "set_right_margin_parm", short: "smgrp"),
    Entry.new(long: "set_top_margin", short: "smgt"),
    Entry.new(long: "set_top_margin_parm", short: "smgtp"),
    Entry.new(long: "start_bit_image", short: "sbim"),
    Entry.new(long: "start_char_set_def", short: "scsd"),
    Entry.new(long: "stop_bit_image", short: "rbim"),
    Entry.new(long: "stop_char_set_def", short: "rcsd"),
    Entry.new(long: "subscript_characters", short: "subcs"),
    Entry.new(long: "superscript_characters", short: "supcs"),
    Entry.new(long: "these_cause_cr", short: "docr"),
    Entry.new(long: "zero_motion", short: "zerom"),
    Entry.new(long: "char_set_names", short: "csnm"),
    Entry.new(long: "key_mouse", short: "kmous"),
    Entry.new(long: "mouse_info", short: "minfo"),
    Entry.new(long: "req_mouse_pos", short: "reqmp"),
    Entry.new(long: "get_mouse", short: "getm"),
    Entry.new(long: "set_a_foreground", short: "setaf"),
    Entry.new(long: "set_a_background", short: "setab"),
    Entry.new(long: "pkey_plab", short: "pfxl"),
    Entry.new(long: "device_type", short: "devt"),
    Entry.new(long: "code_set_init", short: "csin"),
    Entry.new(long: "set0_des_seq", short: "s0ds"),
    Entry.new(long: "set1_des_seq", short: "s1ds"),
    Entry.new(long: "set2_des_seq", short: "s2ds"),
    Entry.new(long: "set3_des_seq", short: "s3ds"),
    Entry.new(long: "set_lr_margin", short: "smglr"),
    Entry.new(long: "set_tb_margin", short: "smgtb"),
    Entry.new(long: "bit_image_repeat", short: "birep"),
    Entry.new(long: "bit_image_newline", short: "binel"),
    Entry.new(long: "bit_image_carriage_return", short: "bicr"),
    Entry.new(long: "color_names", short: "colornm"),
    Entry.new(long: "define_bit_image_region", short: "defbi"),
    Entry.new(long: "end_bit_image_region", short: "endbi"),
    Entry.new(long: "set_color_band", short: "setcolor"),
    Entry.new(long: "set_page_length", short: "slines"),
    Entry.new(long: "display_pc_char", short: "dispc"),
    Entry.new(long: "enter_pc_charset_mode", short: "smpch"),
    Entry.new(long: "exit_pc_charset_mode", short: "rmpch"),
    Entry.new(long: "enter_scancode_mode", short: "smsc"),
    Entry.new(long: "exit_scancode_mode", short: "rmsc"),
    Entry.new(long: "pc_term_options", short: "pctrm"),
    Entry.new(long: "scancode_escape", short: "scesc"),
    Entry.new(long: "alt_scancode_esc", short: "scesa"),
    Entry.new(long: "enter_horizontal_hl_mode", short: "ehhlm"),
    Entry.new(long: "enter_left_hl_mode", short: "elhlm"),
    Entry.new(long: "enter_low_hl_mode", short: "elohlm"),
    Entry.new(long: "enter_right_hl_mode", short: "erhlm"),
    Entry.new(long: "enter_top_hl_mode", short: "ethlm"),
    Entry.new(long: "enter_vertical_hl_mode", short: "evhlm"),
    Entry.new(long: "set_a_attributes", short: "sgr1"),
    Entry.new(long: "set_pglen_inch", short: "slength"),
    Entry.new(long: "termcap_init2", short: "OTi2"),
    Entry.new(long: "termcap_reset", short: "OTrs"),
    Entry.new(long: "linefeed_if_not_lf", short: "OTnl"),
    Entry.new(long: "backspace_if_not_bs", short: "OTbs"),
    Entry.new(long: "other_non_function_keys", short: "OTko"),
    Entry.new(long: "arrow_key_map", short: "OTma"),
    Entry.new(long: "acs_ulcorner", short: "OTG2"),
    Entry.new(long: "acs_llcorner", short: "OTG3"),
    Entry.new(long: "acs_urcorner", short: "OTG1"),
    Entry.new(long: "acs_lrcorner", short: "OTG4"),
    Entry.new(long: "acs_ltee", short: "OTGR"),
    Entry.new(long: "acs_rtee", short: "OTGL"),
    Entry.new(long: "acs_btee", short: "OTGU"),
    Entry.new(long: "acs_ttee", short: "OTGD"),
    Entry.new(long: "acs_hline", short: "OTGH"),
    Entry.new(long: "acs_vline", short: "OTGV"),
    Entry.new(long: "acs_plus", short: "OTGC"),
    Entry.new(long: "memory_lock", short: "meml"),
    Entry.new(long: "memory_unlock", short: "memu"),
    Entry.new(long: "box_chars_1", short: "box1"),
  ]
end
