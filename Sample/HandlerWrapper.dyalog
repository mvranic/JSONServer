 res←HandlerWrapper arg
⍝ Handler wrapper. 
 event context←arg
 fn←'halloapl'
 ⎕←'Start handler wrapper for ",fn,".'
 res←(⍎fn)arg
 ⎕←'Stop handler wrapper for ",fn,".'