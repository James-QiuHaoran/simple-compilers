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
L096:
	push	sb[0]
	push	sb[1]
	push	sb[1]
	mul
	compLT
	j0	L097
	push	"The "
	puts_
	push	sb[0]
	puti_
	push	"-th round:"
	puts
	push	0
	pop	sb[29]
L100:
	push	sb[29]
	push	sb[1]
	push	2
	add
	compLT
	j0	L099
	push	'-'
	putc_
L098:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L100
L099:
	push	""
	puts
	push	0
	pop	sb[29]
L103:
	push	sb[29]
	push	sb[1]
	compLT
	j0	L102
	push	'|'
	putc_
	push	0
	pop	sb[30]
L106:
	push	sb[30]
	push	sb[1]
	compLT
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
	putc_
L104:
	push	sb[30]
	push	1
	add
	pop	sb[30]
	jmp	L106
L105:
	push	"|"
	puts
L101:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L103
L102:
	push	0
	pop	sb[29]
L109:
	push	sb[29]
	push	sb[1]
	push	2
	add
	compLT
	j0	L108
	push	'-'
	putc_
L107:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L109
L108:
	push	""
	puts
	push	1
	neg
	pop	sb[31]
L110:
	push	sb[31]
	push	0
	compLT
	j0	L111
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
	j0	L112
	push	"Index-x unlawful, plz re-enter!"
	puts
	push	1
	neg
	pop	sb[31]
	jmp	L113
L112:
	push	sb[33]
	push	sb[1]
	compGE
	push	sb[33]
	push	0
	compLT
	or
	j0	L114
	push	"Index-y unlawful, plz re-enter!"
	puts
	push	1
	neg
	pop	sb[31]
	jmp	L115
L114:
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
	j0	L116
	push	"Cell occupied, plz re-enter!"
	puts
	push	1
	neg
	pop	sb[31]
	jmp	L117
L116:
	push	1
	pop	sb[31]
L117:
L115:
L113:
	jmp	L110
L111:
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
	j0	L118
	jmp	L097
L118:
	push	0
	pop	sb[29]
L121:
	push	sb[29]
	push	sb[1]
	compLT
	j0	L120
	push	0
	pop	sb[30]
L124:
	push	sb[30]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L123
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
	j0	L125
	push	"test: player 1 won!"
	puts
	push	1
	pop	sb[2]
	push	1
	pop	sb[28]
L125:
L122:
	push	sb[30]
	push	1
	add
	pop	sb[30]
	jmp	L124
L123:
L119:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L121
L120:
	push	sb[28]
	push	1
	compEQ
	j0	L126
	jmp	L097
L126:
	push	0
	pop	sb[29]
L129:
	push	sb[29]
	push	sb[1]
	compLT
	j0	L128
	push	0
	pop	sb[30]
L132:
	push	sb[30]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L131
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
	j0	L133
	push	1
	pop	sb[2]
	push	1
	pop	sb[28]
L133:
L130:
	push	sb[30]
	push	1
	add
	pop	sb[30]
	jmp	L132
L131:
L127:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L129
L128:
	push	sb[28]
	push	1
	compEQ
	j0	L134
	jmp	L097
L134:
	push	0
	pop	sb[29]
L137:
	push	sb[29]
	push	sb[1]
	push	2
	sub
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
	j0	L141
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
	j0	L142
	push	1
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
	jmp	L097
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
	push	sb[1]
	push	3
	sub
	pop	sb[30]
L149:
	push	sb[30]
	push	0
	compGE
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
	push	'o'
	compEQ
	j0	L151
	push	1
	pop	sb[2]
	push	1
	pop	sb[28]
L151:
L150:
L147:
	push	sb[30]
	push	1
	sub
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
	jmp	L097
L152:
	push	1
	neg
	pop	sb[31]
L153:
	push	sb[31]
	push	0
	compLT
	j0	L154
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
	j0	L155
	push	"Index-x unlawful, plz re-enter!"
	puts
	push	1
	neg
	pop	sb[31]
	jmp	L156
L155:
	push	sb[35]
	push	sb[1]
	compGE
	push	sb[35]
	push	0
	compLT
	or
	j0	L157
	push	"Index-y unlawful, plz re-enter!"
	puts
	push	1
	neg
	pop	sb[31]
	jmp	L158
L157:
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
	j0	L159
	push	"Cell occupied, plz re-enter!"
	puts
	push	1
	neg
	pop	sb[31]
	jmp	L160
L159:
	push	1
	pop	sb[31]
L160:
L158:
L156:
	jmp	L153
L154:
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
	j0	L161
	jmp	L097
L161:
	push	0
	pop	sb[29]
L164:
	push	sb[29]
	push	sb[1]
	compLT
	j0	L163
	push	0
	pop	sb[30]
L167:
	push	sb[30]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L166
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
	j0	L168
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
	j0	L169
	push	2
	pop	sb[2]
	push	1
	pop	sb[28]
L169:
L168:
L165:
	push	sb[30]
	push	1
	add
	pop	sb[30]
	jmp	L167
L166:
L162:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L164
L163:
	push	sb[28]
	push	1
	compEQ
	j0	L170
	jmp	L097
L170:
	push	0
	pop	sb[29]
L173:
	push	sb[29]
	push	sb[1]
	compLT
	j0	L172
	push	0
	pop	sb[30]
L176:
	push	sb[30]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L175
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
	j0	L177
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
	j0	L178
	push	2
	pop	sb[2]
	push	1
	pop	sb[28]
L178:
L177:
L174:
	push	sb[30]
	push	1
	add
	pop	sb[30]
	jmp	L176
L175:
L171:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L173
L172:
	push	sb[28]
	push	1
	compEQ
	j0	L179
	jmp	L097
L179:
	push	0
	pop	sb[29]
L182:
	push	sb[29]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L181
	push	0
	pop	sb[30]
L185:
	push	sb[30]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L184
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
	j0	L186
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
	j0	L187
	push	2
	pop	sb[2]
	push	1
	pop	sb[28]
L187:
L186:
L183:
	push	sb[30]
	push	1
	add
	pop	sb[30]
	jmp	L185
L184:
L180:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L182
L181:
	push	sb[28]
	push	1
	compEQ
	j0	L188
	jmp	L097
L188:
	push	0
	pop	sb[29]
L191:
	push	sb[29]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L190
	push	sb[1]
	push	3
	sub
	pop	sb[30]
L194:
	push	sb[30]
	push	0
	compGE
	j0	L193
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
	j0	L195
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
	j0	L196
	push	2
	pop	sb[2]
	push	1
	pop	sb[28]
L196:
L195:
L192:
	push	sb[30]
	push	1
	sub
	pop	sb[30]
	jmp	L194
L193:
L189:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L191
L190:
	push	sb[28]
	push	1
	compEQ
	j0	L197
	jmp	L097
L197:
	jmp	L096
L097:
	push	sb[0]
	push	sb[1]
	push	sb[1]
	mul
	compEQ
	j0	L198
	push	"No one won!"
	puts
	jmp	L199
L198:
	push	sb[2]
	push	1
	compEQ
	j0	L200
	push	"Player 1 won!"
	puts
	jmp	L201
L200:
	push	sb[2]
	push	2
	compEQ
	j0	L202
	push	"Player 2 won!"
	puts
L202:
L201:
L199:
	end
	push	0
	pop	sb[29]
L206:
	push	sb[29]
	push	sb[1]
	push	2
	add
	compLT
	j0	L205
	push	'-'
	putc_
L204:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L206
L205:
	push	""
	puts
	push	0
	pop	sb[29]
L209:
	push	sb[29]
	push	sb[1]
	compLT
	j0	L208
	push	'|'
	putc_
	push	0
	pop	sb[30]
L212:
	push	sb[30]
	push	sb[1]
	compLT
	j0	L211
	push	fp[-4]
	push	0
	push	sb[29]
	add
	add
	pop	ac
	push	ac[0]
	putc_
L210:
	push	sb[30]
	push	1
	add
	pop	sb[30]
	jmp	L212
L211:
	push	"|"
	puts
L207:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L209
L208:
	push	0
	pop	sb[29]
L215:
	push	sb[29]
	push	sb[1]
	push	2
	add
	compLT
	j0	L214
	push	'-'
	putc_
L213:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L215
L214:
	push	""
	puts
	ret
	push	fp[-5]
	push	sb[1]
	compGE
	push	fp[-5]
	push	0
	compLT
	or
	j0	L217
	push	"Index-x unlawful, plz re-enter!"
	puts
	push	1
	neg
	ret
	jmp	L218
L217:
	push	fp[-4]
	push	sb[1]
	compGE
	push	fp[-4]
	push	0
	compLT
	or
	j0	L219
	push	"Index-y unlawful, plz re-enter!"
	puts
	push	1
	neg
	ret
	jmp	L220
L219:
	push	sb
	push	3
	push	0
	push	fp[-5]
	add
	add
	add
	pop	ac
	push	ac[0]
	push	' '
	compNE
	j0	L221
	push	"Cell occupied, plz re-enter!"
	puts
	push	1
	neg
	ret
	jmp	L222
L221:
	push	1
	ret
L222:
L220:
L218:
	ret
	push	0
	pop	sb[29]
L226:
	push	sb[29]
	push	sb[1]
	compLT
	j0	L225
	push	0
	pop	sb[30]
L229:
	push	sb[30]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L228
	push	fp[-4]
	push	0
	push	sb[29]
	add
	add
	pop	ac
	push	ac[0]
	push	fp[-4]
	push	0
	push	sb[29]
	add
	add
	pop	ac
	push	ac[0]
	compEQ
	push	fp[-4]
	push	0
	push	sb[29]
	add
	add
	pop	ac
	push	ac[0]
	push	fp[-4]
	push	0
	push	sb[29]
	add
	add
	pop	ac
	push	ac[0]
	compEQ
	and
	j0	L230
	push	fp[-4]
	push	0
	push	sb[29]
	add
	add
	pop	ac
	push	ac[0]
	push	'o'
	compEQ
	j0	L231
	push	1
	ret
	jmp	L232
L231:
	push	fp[-4]
	push	0
	push	sb[29]
	add
	add
	pop	ac
	push	ac[0]
	push	'*'
	compEQ
	j0	L233
	push	1
	neg
	ret
L233:
L232:
L230:
L227:
	push	sb[30]
	push	1
	add
	pop	sb[30]
	jmp	L229
L228:
L224:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L226
L225:
	push	0
	pop	sb[29]
L236:
	push	sb[29]
	push	sb[1]
	compLT
	j0	L235
	push	0
	pop	sb[30]
L239:
	push	sb[30]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L238
	push	fp[-4]
	push	0
	push	sb[30]
	add
	add
	pop	ac
	push	ac[0]
	push	fp[-4]
	push	0
	push	sb[30]
	push	1
	add
	add
	add
	pop	ac
	push	ac[0]
	compEQ
	push	fp[-4]
	push	0
	push	sb[30]
	add
	add
	pop	ac
	push	ac[0]
	push	fp[-4]
	push	0
	push	sb[30]
	push	2
	add
	add
	add
	pop	ac
	push	ac[0]
	compEQ
	and
	j0	L240
	push	fp[-4]
	push	0
	push	sb[30]
	add
	add
	pop	ac
	push	ac[0]
	push	'o'
	compEQ
	j0	L241
	push	1
	ret
	jmp	L242
L241:
	push	fp[-4]
	push	0
	push	sb[30]
	add
	add
	pop	ac
	push	ac[0]
	push	'*'
	compEQ
	j0	L243
	push	1
	neg
	ret
L243:
L242:
L240:
L237:
	push	sb[30]
	push	1
	add
	pop	sb[30]
	jmp	L239
L238:
L234:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L236
L235:
	push	0
	pop	sb[29]
L246:
	push	sb[29]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L245
	push	0
	pop	sb[30]
L249:
	push	sb[30]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L248
	push	fp[-4]
	push	0
	push	sb[29]
	add
	add
	pop	ac
	push	ac[0]
	push	fp[-4]
	push	0
	push	sb[29]
	push	1
	add
	add
	add
	pop	ac
	push	ac[0]
	compEQ
	push	fp[-4]
	push	0
	push	sb[29]
	add
	add
	pop	ac
	push	ac[0]
	push	fp[-4]
	push	0
	push	sb[29]
	push	2
	add
	add
	add
	pop	ac
	push	ac[0]
	compEQ
	and
	j0	L250
	push	fp[-4]
	push	0
	push	sb[29]
	add
	add
	pop	ac
	push	ac[0]
	push	'o'
	compEQ
	j0	L251
	push	1
	ret
	jmp	L252
L251:
	push	fp[-4]
	push	0
	push	sb[29]
	add
	add
	pop	ac
	push	ac[0]
	push	'*'
	compEQ
	j0	L253
	push	1
	neg
	ret
L253:
L252:
L250:
L247:
	push	sb[30]
	push	1
	add
	pop	sb[30]
	jmp	L249
L248:
L244:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L246
L245:
	push	0
	pop	sb[29]
L256:
	push	sb[29]
	push	sb[1]
	push	2
	sub
	compLT
	j0	L255
	push	sb[1]
	push	3
	sub
	pop	sb[30]
L259:
	push	sb[30]
	push	0
	compGE
	j0	L258
	push	fp[-4]
	push	0
	push	sb[29]
	add
	add
	pop	ac
	push	ac[0]
	push	fp[-4]
	push	0
	push	sb[29]
	push	1
	add
	add
	add
	pop	ac
	push	ac[0]
	compEQ
	push	fp[-4]
	push	0
	push	sb[29]
	add
	add
	pop	ac
	push	ac[0]
	push	fp[-4]
	push	0
	push	sb[29]
	push	2
	add
	add
	add
	pop	ac
	push	ac[0]
	compEQ
	and
	j0	L260
	push	fp[-4]
	push	0
	push	sb[29]
	add
	add
	pop	ac
	push	ac[0]
	push	'o'
	compEQ
	j0	L261
	push	1
	ret
	jmp	L262
L261:
	push	fp[-4]
	push	0
	push	sb[29]
	add
	add
	pop	ac
	push	ac[0]
	push	'*'
	compEQ
	j0	L263
	push	1
	neg
	ret
L263:
L262:
L260:
L257:
	push	sb[30]
	push	1
	sub
	pop	sb[30]
	jmp	L259
L258:
L254:
	push	sb[29]
	push	1
	add
	pop	sb[29]
	jmp	L256
L255:
	push	0
	ret
	ret
