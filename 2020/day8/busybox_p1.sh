awk 'BEGIN { acc_count=0; pos=1 }

function check_pos(pos) {
  pos_count[pos] += 1
  if (pos_count[pos] > 1) { print acc_count; exit }
}

function acc(num) { acc_count += num; pos += 1 }

function jmp(num) { pos += num}

function nop(num) { pos += 1 }

function exec_cmd(cmd, num) {
  if (cmd == "acc") { acc(num) }
  if (cmd == "jmp") { jmp(num) }
  if (cmd == "nop") { nop(num) }
}

{ cmd_list[NR] = $0 }

END {
  while (1) {
    split(cmd_list[pos], arr, " ")
    check_pos(pos)
    exec_cmd(arr[1], arr[2])
}}' input