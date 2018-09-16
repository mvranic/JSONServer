 {ref}←AutoStart;empty;validParams;mask;values;params;param;value;rc;msg;getEnv;NoSession;ts;t;commits;n;numParams
⍝ JSONServer automatic startup
⍝ General logic:
⍝   Command line parameters take priority over configuration file which takes priority over default
 ⎕←'Start Auto start.'
 empty←0∊⍴
 getEnv←{2 ⎕NQ'.' 'GetEnvironment'⍵}

 numParams←0 0 1 0 0 1 1 1 0 0
 validParams←'ConfigFile' 'CodeLocation' 'Port' 'InitializeFn' 'AllowedFns' 'Threaded' 'AllowHttpGet' 'Logging' 'Handler' 'HtmlInterface' ⍝ to be added - 'Secure' 'RootCertDir' 'SSLValidation' 'ServerCertFile' 'ServerKeyFile'
 values←getEnv¨validParams
 mask←~empty¨values
 ((mask∧numParams)/values)←⍎¨(mask∧numParams)/values
 params←mask⌿validParams,⍪values
 NoSession←~empty getEnv'NoSession'

 ref←'No server running'
 :If ~empty params
     ref←⎕NEW #.JSONServer

     :For (param value) :In ↓params  ⍝ need to load one at a time because params can override what's in the configuration file
         ⎕←'Assign param: ( ',param ,' , ',(⍕value),' )'
         param(ref{⍺⍺⍎⍺,'←⍵'})value
         :If 'ConfigFile'≡param
             :If 0≠⊃(rc msg)←ref.LoadConfiguration value
                 ∘∘∘
             :EndIf
         :EndIf
     :EndFor

     ⎕←'Starting JSON server.'
     :If 0≠⊃(rc msg)←ref.Start
         ('Unable to start server - ',msg)⎕SIGNAL 16
     :EndIf

     :If NoSession∨'R'=3⊃#.⎕WG'APLVersion' ⍝ no session or runtime?
         :While ref.Running
             {}⎕DL 10
         :EndWhile
     :EndIf
 :EndIf
 ⎕←'Finished Auto start.'
   