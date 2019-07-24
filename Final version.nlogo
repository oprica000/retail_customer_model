__includes["Customers.nls" "Shops.nls" "Ads.nls" "Hubnet.nls"]




globals
[
  days
  index-list
]

to startup
  clear-all
  hubnet-reset
end

to setup
  set-default-shape shops "building store"
  set-default-shape customers "face neutral"
  clear-patches
  clear-all-plots
  clear-output
  reset-ticks
  ask shops [die]
  ask customers [die]
  clear-turtles


  create-shops Numar-magazine
  [
    while [ xcor < min-pxcor + 2 or xcor > max-pxcor - 2 or ycor < min-pycor + 2 or ycor > max-pycor - 2 or any? other shops in-radius 4]
    [
      setxy random-xcor random-ycor
    ]
    set color yellow
    set size 3
    set is-bankrupt false
    set popularity Popularitate-initiala
    set price Pret
    set sales 0
    set StocZilnic Stoc-initial
    set comandaaprov 0
    set Istoricvanzari []
    set valuta Valutal-initiala
    set shop-supply-cost Cost-aprovizionare
    set cost-fix Cost-fix-setup
    set perioada-cost-fix Perioada-cost-fix-setup
    set comanda-minima Comanda-minima-Setup
    set rate-of-popilarity-reduction Rata-reducere-popularitate
    set quality-value (8 * Cost-aprovizionare + 2 * Cost-fix-setup) / 2
    set product-life base-product-life  - product-life-variation / 2 + (random product-life-variation)
    set last-ad-made 0
    set ZileADS ZileADS-setup
  ]
 ; inspect shop 0
  set days 0
  set index-list []
end




to go
  if not any? shops with [ color != grey ]
  [
   user-message ("All shops have gone bankrupt.")
  ]

  every 0.01
  [
    listen-clients
    if NOT pause
    [
      customer-method
      become-more-popular
      decay-popularity
      move-ads
      day-count-method
      tick
    ]
  ]
end


to day-count-method
  if ticks mod 24 = 0
  [
    set days days + 1
    shops-method
  ]
end

to-report coin-flip?
  report random 2 = 0
end
@#$#@#$#@
GRAPHICS-WINDOW
1138
31
1492
386
-1
-1
8.44
1
10
1
1
1
0
1
1
1
-20
20
-20
20
0
0
1
ticks
30.0

SLIDER
596
309
768
342
Stoc-initial
Stoc-initial
0
500
20.0
1
1
NIL
HORIZONTAL

BUTTON
9
29
72
62
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
73
29
136
62
NIL
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
136
29
226
62
go forever
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
398
343
595
376
Rata-reducere-popularitate
Rata-reducere-popularitate
0
100
2.0
1
1
%
HORIZONTAL

SLIDER
399
309
595
342
Incrementare-popularitate
Incrementare-popularitate
0
100
4.0
1
1
NIL
HORIZONTAL

SLIDER
7
127
179
160
Numar-cumparatori
Numar-cumparatori
0
1000
60.0
1
1
NIL
HORIZONTAL

MONITOR
875
234
932
279
Ziua
days
17
1
11

INPUTBOX
399
468
529
528
Comanda-minima-setup
30.0
1
0
Number

SLIDER
595
376
767
409
ZileADS-setup
ZileADS-setup
5
10
5.0
1
1
NIL
HORIZONTAL

SLIDER
8
95
180
128
Numar-magazine
Numar-magazine
1
5
1.0
1
1
NIL
HORIZONTAL

SLIDER
398
376
595
409
Popularitate-initiala
Popularitate-initiala
0
100
100.0
1
1
NIL
HORIZONTAL

MONITOR
811
234
874
279
Total sales
sum [ sales ] of shops
17
1
11

INPUTBOX
398
410
448
470
Pret
15.0
1
0
Number

INPUTBOX
449
410
552
470
Cost-aprovizionare
5.0
1
0
Number

PLOT
820
31
1135
227
Plot
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Total sales" 1.0 0 -16777216 true "" "plotxy days (sum [ daily-sales ] of shops)"
"Total inventory" 1.0 0 -7500403 true "" "plotxy days (sum [ closing-inventory ] of shops)"

SLIDER
595
343
767
376
Valutal-initiala
Valutal-initiala
0
100
100.0
1
1
NIL
HORIZONTAL

INPUTBOX
551
410
631
470
Cost-fix-setup
50.0
1
0
Number

INPUTBOX
630
410
768
470
Perioada-cost-fix-setup
2.0
1
0
Number

PLOT
935
234
1135
384
Popularity distribution
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" "clear-plot\nforeach sort [ popularity ] of shops [[the-size] ->\n  plotxy mean [ who ] of shops with [ popularity = the-size ] the-size \n]"
PENS
"default" 1.0 1 -16777216 true "" ""

SLIDER
3
328
161
361
base-ad-quality
base-ad-quality
0
20
4.0
1
1
NIL
HORIZONTAL

SLIDER
2
362
161
395
base-ad-quality-variance
base-ad-quality-variance
0
1
0.0
0.1
1
NIL
HORIZONTAL

SLIDER
162
328
327
361
base-uniqueness
base-uniqueness
0
100
4.0
1
1
NIL
HORIZONTAL

SLIDER
162
361
328
394
base-uniqueness-variance
base-uniqueness-variance
0
1
0.0
0.1
1
NIL
HORIZONTAL

SWITCH
136
62
226
95
pause
pause
1
1
-1000

BUTTON
9
62
137
95
generate customers
generate-customers
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
430
233
602
266
prag-incrementare
prag-incrementare
0
1
1.0
0.1
1
NIL
HORIZONTAL

SWITCH
653
35
750
68
show-print
show-print
1
1
-1000

SLIDER
257
234
429
267
max-buy-qty
max-buy-qty
0
10
2.0
1
1
NIL
HORIZONTAL

TEXTBOX
75
10
155
28
Control general
11
0.0
1

TEXTBOX
555
293
639
311
Control magazine
11
0.0
1

TEXTBOX
124
307
205
325
Control reclame
11
0.0
1

TEXTBOX
394
14
462
32
Control clienti
11
0.0
1

TEXTBOX
671
10
737
28
Miscellaneous
11
0.0
1

TEXTBOX
1124
10
1164
28
Output
11
0.0
1

SLIDER
257
102
429
135
min-income
min-income
0
100
5.0
1
1
NIL
HORIZONTAL

SLIDER
429
102
601
135
max-income
max-income
0
100
25.0
1
1
NIL
HORIZONTAL

SLIDER
257
69
429
102
min-starting-debit
min-starting-debit
0
100
20.0
1
1
NIL
HORIZONTAL

SLIDER
429
69
601
102
max-starting-debit
max-starting-debit
0
100
30.0
1
1
NIL
HORIZONTAL

SLIDER
257
37
429
70
min-resistance
min-resistance
0
100
34.0
1
1
NIL
HORIZONTAL

SLIDER
429
37
601
70
max-resistance
max-resistance
0
100
50.0
1
1
NIL
HORIZONTAL

SLIDER
257
135
429
168
min-persuasion
min-persuasion
0
1
0.25
0.01
1
NIL
HORIZONTAL

SLIDER
430
135
602
168
max-persuasion
max-persuasion
0
1
1.0
0.01
1
NIL
HORIZONTAL

SLIDER
257
169
429
202
min-starting-opinion
min-starting-opinion
-100
100
-10.0
1
1
NIL
HORIZONTAL

SLIDER
431
169
603
202
max-starting-opinion
max-starting-opinion
-100
100
50.0
1
1
NIL
HORIZONTAL

SLIDER
257
202
429
235
min-paycheck-period
min-paycheck-period
0
100
1.0
1
1
NIL
HORIZONTAL

SLIDER
430
201
602
234
max-paycheck-period
max-paycheck-period
0
100
4.0
1
1
NIL
HORIZONTAL

SLIDER
2
395
162
428
ad-cost-base
ad-cost-base
0
100
5.0
1
1
NIL
HORIZONTAL

SLIDER
3
429
163
462
quality-cost-multi
quality-cost-multi
0
10
0.0
0.1
1
NIL
HORIZONTAL

SLIDER
163
429
331
462
uniqueness-cost-multi
uniqueness-cost-multi
0
10
0.0
0.1
1
NIL
HORIZONTAL

SLIDER
161
396
328
429
ads-max-no
ads-max-no
0
100
20.0
1
1
NIL
HORIZONTAL

SLIDER
3
462
164
495
ad-cooldown
ad-cooldown
0
100
50.0
1
1
days
HORIZONTAL

INPUTBOX
528
469
634
529
base-product-life
48.0
1
0
Number

INPUTBOX
634
468
768
528
product-life-variation
0.0
1
0
Number

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

building store
false
0
Rectangle -7500403 true true 30 45 45 240
Rectangle -16777216 false false 30 45 45 165
Rectangle -7500403 true true 15 165 285 255
Rectangle -16777216 true false 120 195 180 255
Line -7500403 true 150 195 150 255
Rectangle -16777216 true false 30 180 105 240
Rectangle -16777216 true false 195 180 270 240
Line -16777216 false 0 165 300 165
Polygon -7500403 true true 0 165 45 135 60 90 240 90 255 135 300 165
Rectangle -7500403 true true 0 0 75 45
Rectangle -16777216 false false 0 0 75 45

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.0.3
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
VIEW
352
124
781
553
0
0
0
1
1
1
1
1
0
1
1
1
-20
20
-20
20

BUTTON
14
10
112
43
create-shop
NIL
NIL
1
T
OBSERVER
NIL
NIL

MONITOR
120
10
207
59
client-shop-id
NIL
3
1

MONITOR
207
10
264
59
Valuta
NIL
3
1

MONITOR
264
10
435
59
Sales-history
NIL
3
1

MONITOR
434
10
503
59
Popularity
NIL
3
1

MONITOR
503
10
560
59
Days
NIL
3
1

MONITOR
559
10
673
59
Costs-per-product
NIL
3
1

SLIDER
46
92
218
125
Price
Price
0.0
100.0
0
1.0
1
NIL
HORIZONTAL

SLIDER
46
127
218
160
ZileADS
ZileADS
5.0
10.0
0
1.0
1
NIL
HORIZONTAL

SLIDER
46
161
218
194
x-cor
x-cor
-20.0
20.0
0
1.0
1
NIL
HORIZONTAL

SLIDER
47
195
219
228
y-cor
y-cor
-20.0
20.0
0
1.0
1
NIL
HORIZONTAL

INPUTBOX
239
93
314
153
shop-color
0.0
1
0
Color

@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
