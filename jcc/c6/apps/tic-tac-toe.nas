	push	sp
	push	36
	add
	pop	sp
	push	0
	pop	sb[0]
	push	5
	pop	sb[1]
	push	0
	pop	sb[2]
	push	' '
	push	sb
	push	3
	add
	pop	ac
	pop	ac[0]
	push	ac[0]
	pop	ac[1]
	push	ac[1]
	pop	ac[2]
	push	ac[2]
	pop	ac[3]
	push	ac[3]
	pop	ac[4]
	push	ac[4]
	pop	ac[5]
	push	ac[5]
	pop	ac[6]
	push	ac[6]
	pop	ac[7]
	push	ac[7]
	pop	ac[8]
	push	ac[8]
	pop	ac[9]
	push	ac[9]
	pop	ac[10]
	push	ac[10]
	pop	ac[11]
	push	ac[11]
	pop	ac[12]
	push	ac[12]
	pop	ac[13]
	push	ac[13]
	pop	ac[14]
	push	ac[14]
	pop	ac[15]
	push	ac[15]
	pop	ac[16]
	push	ac[16]
	pop	ac[17]
	push	ac[17]
	pop	ac[18]
	push	ac[18]
	pop	ac[19]
	push	ac[19]
	pop	ac[20]
	push	ac[20]
	pop	ac[21]
	push	ac[21]
	pop	ac[22]
	push	ac[22]
	pop	ac[23]
	push	ac[23]
	pop	ac[24]
	push	0
	pop	sb[28]
L060:
	push	sb[0]
	push	sb[1]
	push	sb[1]
	mul
	compLT
	j0	L061
	push	"The "
	puts_
	push	sb[0]
	puti_
	push	"-th round:"
	puts
	push	0
	pop	sb[29]
L064:
	push	sb[29]
	push	sb[1]
	push	2
	add
	compLT
	j0	L063
	push	'-'
	putc_
L062:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L064
L063:
	push	""
	puts
	push	0
	pop	sb[29]
L067:
	push	sb[29]
	push	sb[1]
	compLT
	j0	L066
	push	'|'
	putc_
	push	0
	pop	sb[30]
L070:
	push	sb[30]
	push	sb[1]
	compLT
	j0	L069
	push	sb
	push	3
	push	0
	push	sb[29]
	add
	push	5
	mul
	push	sb[30]
	add
	add
	add
	pop	ac
	push	ac[0]
	putc_
L068:
	push	sb[30]
	push	1
	add
	pop	sb[30]
	jmp	L070
L069:
	push	"|"
	puts
L065:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L067
L066:
	push	0
	pop	sb[29]
L073:
	push	sb[29]
	push	sb[1]
	push	2
	add
	compLT
	j0	L072
	push	'-'
	putc_
L071:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L073
L072:
	push	""
	puts
	push	1
	neg
	pop	sb[31]
L074:
	push	sb[31]
	push	0
	compLT
	j0	L075
	push	"Player 1 - enter x:"
	puts
	geti
	pop	sb[32]
	push	"Player 1 - enter y:"
	puts
	geti
	pop	sb[33]
	push	"Player 1: ("
	puts_
	push	sb[32]
	puti_
	push	", "
	puts_
	push	sb[33]
	puti_
	push	")"
	puts
	push	sb[32]
	push	sb[1]
	compGE
	push	sb[32]
	push	0
	compLT
	or
	j0	L076
	push	"Index-x unlawful, plz re-enter!"
	puts
	push	1
	neg
	pop	sb[31]
	jmp	L077
L076:
	push	sb[33]
	push	sb[1]
	compGE
	push	sb[33]
	push	0
	compLT
	or
	j0	L078
	push	"Index-y unlawful, plz re-enter!"
	puts
	push	1
	neg
	pop	sb[31]
	jmp	L079
L078:
	push	sb
	push	3
	push	0
	push	sb[32]
	add
	push	5
	mul
	push	sb[33]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	' '
	compNE
	j0	L080
	push	"Cell occupied, plz re-enter!"
	puts
	push	1
	neg
	pop	sb[31]
	jmp	L081
L080:
	push	1
	pop	sb[31]
L081:
L079:
L077:
	jmp	L074
L075:
	push	'o'
	push	sb
	push	3
	push	0
	push	sb[32]
	add
	push	5
	mul
	push	sb[33]
	add
	add
	add
	pop	ac
	pop	ac[0]
	push	"board["
	puts_
	push	sb[32]
	puti_
	push	"]["
	puts_
	push	sb[33]
	puti_
	push	"] is set to "
	puts_
	push	'o'
	putc
	push	sb[0]
	push	1
	add
	pop	sb[0]
	push	sb[0]
	push	sb[1]
	push	sb[1]
	mul
	compGE
	j0	L082
	jmp	L061
L082:
	push	0
	pop	sb[29]
L085:
	push	sb[29]
	push	sb[1]
	compLT
	j0	L084
	push	0
	pop	sb[30]
L088:
	push	sb[30]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L087
	push	sb
	push	3
	push	0
	push	sb[29]
	add
	push	5
	mul
	push	sb[30]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	'o'
	compEQ
	push	sb
	push	3
	push	0
	push	sb[29]
	add
	push	5
	mul
	push	sb[30]
	push	1
	add
	add
	add
	add
	pop	ac
	push	ac[0]
	push	'o'
	compEQ
	and
	push	sb
	push	3
	push	0
	push	sb[29]
	add
	push	5
	mul
	push	sb[30]
	push	2
	add
	add
	add
	add
	pop	ac
	push	ac[0]
	push	'o'
	compEQ
	and
	j0	L089
	push	"test: player 1 won!"
	puts
	push	1
	pop	sb[2]
	push	1
	pop	sb[28]
L089:
L086:
	push	sb[30]
	push	1
	add
	pop	sb[30]
	jmp	L088
L087:
L083:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L085
L084:
	push	sb[28]
	push	1
	compEQ
	j0	L090
	jmp	L061
L090:
	push	0
	pop	sb[29]
L093:
	push	sb[29]
	push	sb[1]
	compLT
	j0	L092
	push	0
	pop	sb[30]
L096:
	push	sb[30]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L095
	push	sb
	push	3
	push	0
	push	sb[30]
	add
	push	5
	mul
	push	sb[29]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	'o'
	compEQ
	push	sb
	push	3
	push	0
	push	sb[30]
	push	1
	add
	add
	push	5
	mul
	push	sb[29]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	'o'
	compEQ
	and
	push	sb
	push	3
	push	0
	push	sb[30]
	push	2
	add
	add
	push	5
	mul
	push	sb[29]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	'o'
	compEQ
	and
	j0	L097
	push	1
	pop	sb[2]
	push	1
	pop	sb[28]
L097:
L094:
	push	sb[30]
	push	1
	add
	pop	sb[30]
	jmp	L096
L095:
L091:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L093
L092:
	push	sb[28]
	push	1
	compEQ
	j0	L098
	jmp	L061
L098:
	push	0
	pop	sb[29]
L101:
	push	sb[29]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L100
	push	0
	pop	sb[30]
L104:
	push	sb[30]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L103
	push	sb
	push	3
	push	0
	push	sb[29]
	add
	push	5
	mul
	push	sb[30]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	sb
	push	3
	push	0
	push	sb[29]
	push	1
	add
	add
	push	5
	mul
	push	sb[30]
	push	1
	add
	add
	add
	add
	pop	ac
	push	ac[0]
	compEQ
	push	sb
	push	3
	push	0
	push	sb[29]
	add
	push	5
	mul
	push	sb[30]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	sb
	push	3
	push	0
	push	sb[29]
	push	2
	add
	add
	push	5
	mul
	push	sb[30]
	push	2
	add
	add
	add
	add
	pop	ac
	push	ac[0]
	compEQ
	and
	j0	L105
	push	sb
	push	3
	push	0
	push	sb[29]
	add
	push	5
	mul
	push	sb[30]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	'o'
	compEQ
	j0	L106
	push	1
	pop	sb[2]
	push	1
	pop	sb[28]
L106:
L105:
L102:
	push	sb[30]
	push	1
	add
	pop	sb[30]
	jmp	L104
L103:
L099:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L101
L100:
	push	sb[28]
	push	1
	compEQ
	j0	L107
	jmp	L061
L107:
	push	0
	pop	sb[29]
L110:
	push	sb[29]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L109
	push	sb[1]
	push	3
	sub
	pop	sb[30]
L113:
	push	sb[30]
	push	0
	compGE
	j0	L112
	push	sb
	push	3
	push	0
	push	sb[29]
	add
	push	5
	mul
	push	sb[30]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	sb
	push	3
	push	0
	push	sb[29]
	push	1
	add
	add
	push	5
	mul
	push	sb[30]
	push	1
	sub
	add
	add
	add
	pop	ac
	push	ac[0]
	compEQ
	push	sb
	push	3
	push	0
	push	sb[29]
	add
	push	5
	mul
	push	sb[30]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	sb
	push	3
	push	0
	push	sb[29]
	push	2
	add
	add
	push	5
	mul
	push	sb[30]
	push	2
	sub
	add
	add
	add
	pop	ac
	push	ac[0]
	compEQ
	and
	j0	L114
	push	sb
	push	3
	push	0
	push	sb[29]
	add
	push	5
	mul
	push	sb[30]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	'o'
	compEQ
	j0	L115
	push	1
	pop	sb[2]
	push	1
	pop	sb[28]
L115:
L114:
L111:
	push	sb[30]
	push	1
	sub
	pop	sb[30]
	jmp	L113
L112:
L108:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L110
L109:
	push	sb[28]
	push	1
	compEQ
	j0	L116
	jmp	L061
L116:
	push	1
	neg
	pop	sb[31]
L117:
	push	sb[31]
	push	0
	compLT
	j0	L118
	push	"Player 2 - enter x:"
	puts
	geti
	pop	sb[34]
	push	"Player 2 - enter y:"
	puts
	geti
	pop	sb[35]
	push	"Player 2: ("
	puts_
	push	sb[34]
	puti_
	push	", "
	puts_
	push	sb[35]
	puti_
	push	")"
	puts
	push	sb[34]
	push	sb[1]
	compGE
	push	sb[34]
	push	0
	compLT
	or
	j0	L119
	push	"Index-x unlawful, plz re-enter!"
	puts
	push	1
	neg
	pop	sb[31]
	jmp	L120
L119:
	push	sb[35]
	push	sb[1]
	compGE
	push	sb[35]
	push	0
	compLT
	or
	j0	L121
	push	"Index-y unlawful, plz re-enter!"
	puts
	push	1
	neg
	pop	sb[31]
	jmp	L122
L121:
	push	sb
	push	3
	push	0
	push	sb[34]
	add
	push	5
	mul
	push	sb[35]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	' '
	compNE
	j0	L123
	push	"Cell occupied, plz re-enter!"
	puts
	push	1
	neg
	pop	sb[31]
	jmp	L124
L123:
	push	1
	pop	sb[31]
L124:
L122:
L120:
	jmp	L117
L118:
	push	'*'
	push	sb
	push	3
	push	0
	push	sb[34]
	add
	push	5
	mul
	push	sb[35]
	add
	add
	add
	pop	ac
	pop	ac[0]
	push	"board["
	puts_
	push	sb[32]
	puti_
	push	"]["
	puts_
	push	sb[33]
	puti_
	push	"] is set to "
	puts_
	push	'o'
	putc
	push	sb[0]
	push	1
	add
	pop	sb[0]
	push	sb[0]
	push	sb[1]
	push	sb[1]
	mul
	compGE
	j0	L125
	jmp	L061
L125:
	push	0
	pop	sb[29]
L128:
	push	sb[29]
	push	sb[1]
	compLT
	j0	L127
	push	0
	pop	sb[30]
L131:
	push	sb[30]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L130
	push	sb
	push	3
	push	0
	push	sb[29]
	add
	push	5
	mul
	push	sb[30]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	sb
	push	3
	push	0
	push	sb[29]
	add
	push	5
	mul
	push	sb[30]
	push	1
	add
	add
	add
	add
	pop	ac
	push	ac[0]
	compEQ
	push	sb
	push	3
	push	0
	push	sb[29]
	add
	push	5
	mul
	push	sb[30]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	sb
	push	3
	push	0
	push	sb[29]
	add
	push	5
	mul
	push	sb[30]
	push	2
	add
	add
	add
	add
	pop	ac
	push	ac[0]
	compEQ
	and
	j0	L132
	push	sb
	push	3
	push	0
	push	sb[29]
	add
	push	5
	mul
	push	sb[30]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	'*'
	compEQ
	j0	L133
	push	2
	pop	sb[2]
	push	1
	pop	sb[28]
L133:
L132:
L129:
	push	sb[30]
	push	1
	add
	pop	sb[30]
	jmp	L131
L130:
L126:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L128
L127:
	push	sb[28]
	push	1
	compEQ
	j0	L134
	jmp	L061
L134:
	push	0
	pop	sb[29]
L137:
	push	sb[29]
	push	sb[1]
	compLT
	j0	L136
	push	0
	pop	sb[30]
L140:
	push	sb[30]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L139
	push	sb
	push	3
	push	0
	push	sb[30]
	add
	push	5
	mul
	push	sb[29]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	sb
	push	3
	push	0
	push	sb[30]
	push	1
	add
	add
	push	5
	mul
	push	sb[29]
	add
	add
	add
	pop	ac
	push	ac[0]
	compEQ
	push	sb
	push	3
	push	0
	push	sb[30]
	add
	push	5
	mul
	push	sb[29]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	sb
	push	3
	push	0
	push	sb[30]
	push	2
	add
	add
	push	5
	mul
	push	sb[29]
	add
	add
	add
	pop	ac
	push	ac[0]
	compEQ
	and
	j0	L141
	push	sb
	push	3
	push	0
	push	sb[30]
	add
	push	5
	mul
	push	sb[29]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	'*'
	compEQ
	j0	L142
	push	2
	pop	sb[2]
	push	1
	pop	sb[28]
L142:
L141:
L138:
	push	sb[30]
	push	1
	add
	pop	sb[30]
	jmp	L140
L139:
L135:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L137
L136:
	push	sb[28]
	push	1
	compEQ
	j0	L143
	jmp	L061
L143:
	push	0
	pop	sb[29]
L146:
	push	sb[29]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L145
	push	0
	pop	sb[30]
L149:
	push	sb[30]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L148
	push	sb
	push	3
	push	0
	push	sb[29]
	add
	push	5
	mul
	push	sb[30]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	sb
	push	3
	push	0
	push	sb[29]
	push	1
	add
	add
	push	5
	mul
	push	sb[30]
	push	1
	add
	add
	add
	add
	pop	ac
	push	ac[0]
	compEQ
	push	sb
	push	3
	push	0
	push	sb[29]
	add
	push	5
	mul
	push	sb[30]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	sb
	push	3
	push	0
	push	sb[29]
	push	2
	add
	add
	push	5
	mul
	push	sb[30]
	push	2
	add
	add
	add
	add
	pop	ac
	push	ac[0]
	compEQ
	and
	j0	L150
	push	sb
	push	3
	push	0
	push	sb[29]
	add
	push	5
	mul
	push	sb[30]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	'*'
	compEQ
	j0	L151
	push	2
	pop	sb[2]
	push	1
	pop	sb[28]
L151:
L150:
L147:
	push	sb[30]
	push	1
	add
	pop	sb[30]
	jmp	L149
L148:
L144:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L146
L145:
	push	sb[28]
	push	1
	compEQ
	j0	L152
	jmp	L061
L152:
	push	0
	pop	sb[29]
L155:
	push	sb[29]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L154
	push	sb[1]
	push	3
	sub
	pop	sb[30]
L158:
	push	sb[30]
	push	0
	compGE
	j0	L157
	push	sb
	push	3
	push	0
	push	sb[29]
	add
	push	5
	mul
	push	sb[30]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	sb
	push	3
	push	0
	push	sb[29]
	push	1
	add
	add
	push	5
	mul
	push	sb[30]
	push	1
	sub
	add
	add
	add
	pop	ac
	push	ac[0]
	compEQ
	push	sb
	push	3
	push	0
	push	sb[29]
	add
	push	5
	mul
	push	sb[30]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	sb
	push	3
	push	0
	push	sb[29]
	push	2
	add
	add
	push	5
	mul
	push	sb[30]
	push	2
	sub
	add
	add
	add
	pop	ac
	push	ac[0]
	compEQ
	and
	j0	L159
	push	sb
	push	3
	push	0
	push	sb[29]
	add
	push	5
	mul
	push	sb[30]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	'*'
	compEQ
	j0	L160
	push	2
	pop	sb[2]
	push	1
	pop	sb[28]
L160:
L159:
L156:
	push	sb[30]
	push	1
	sub
	pop	sb[30]
	jmp	L158
L157:
L153:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L155
L154:
	push	sb[28]
	push	1
	compEQ
	j0	L161
	jmp	L061
L161:
	jmp	L060
L061:
	push	sb[0]
	push	sb[1]
	push	sb[1]
	mul
	compEQ
	j0	L162
	push	"No one won!"
	puts
	jmp	L163
L162:
	push	sb[2]
	push	1
	compEQ
	j0	L164
	push	"Player 1 won!"
	puts
	jmp	L165
L164:
	push	sb[2]
	push	2
	compEQ
	j0	L166
	push	"Player 2 won!"
	puts
L166:
L165:
L163:
	end
