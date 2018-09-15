 res←halloapl arg;context;event;obj;data
 event context←arg
 ⎕←'Log a event from function:'
 ⎕←event
 res←'Nothing happened.'
 :Trap 0
    obj←⎕JSON event
 :Else
    ⎕←'Can not parse json'
 :EndTrap
 :Trap 0
    res←obj.data
 :Else
    ⎕←'Can not find data'
    res←'Can not find data'
 :EndTrap

