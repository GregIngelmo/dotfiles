set history filename ~/.gdb_history
set history save

define g
python
import subprocess as p
cmd = ["go", "env", "GOROOT"]
gdb_cmd = "source %s/src/pkg/runtime/runtime-gdb.py" % p.check_output(cmd)[:-1]
gdb.execute(gdb_cmd)
end
