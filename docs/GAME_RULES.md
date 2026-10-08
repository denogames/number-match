# Number Match — Game Rules Specification

## Overview

Number Match is a tactical logic puzzle mobile game where the player clears numbers from a dynamic 9-column grid by identifying matching pairs according to strict adjacency and value rules.

---

## 1. Value Matching Conditions

Two cells are eligible for pairing if either condition is met:
1. **Identical Values**: The numbers in both cells are identical ($v_1 = v_2$, e.g., $1-1, 5-5, 9-9$).
2. **Sum to Ten**: The sum of the two numbers equals exactly 10 ($v_1 + v_2 = 10$, e.g., $1-9, 2-8, 3-7, 4-6, 5-5$).

A cell cannot match with itself. Cleared cells cannot be selected.

---

## 2. Spatial & Reading Order Selection Rules

Two active cells $A$ (index $i$) and $B$ (index $j$), with $i < j$, are selectable if **any** of the following conditions is satisfied:

### Rule 2.1: Reading Order Consecutive
- Cells $A$ and $B$ are consecutive non-empty cells in standard left-to-right, top-to-bottom reading order.
- Every intermediate cell with index $k$ ($i < k < j$) must be cleared.
- **Cross-Row Wrapping**: If cell $A$ is the last active number of row $R$, and cell $B$ is the first active number of row $R+1$ (or a later row if intermediate rows are cleared), they are consecutive in reading order and valid.

### Rule 2.2: Same Row Alignment
- Both cells share row $r$ ($r_A = r_B$).
- All intermediate cells $(r, c)$ between column $c_A$ and column $c_B$ are cleared.

### Rule 2.3: Same Column Alignment
- Both cells share column $c$ ($c_A = c_B$).
- All intermediate cells $(r, c)$ between row $r_A$ and row $r_B$ in column $c$ are cleared. Cells in other columns have no bearing on this line of sight.

### Rule 2.4: Diagonal Alignment
- The cells lie on a $45^\circ$ diagonal: $|r_A - r_B| = |c_A - c_B| > 0$.
- All cells along the straight diagonal path between $(r_A, c_A)$ and $(r_B, c_B)$ must be cleared.

---

## 3. Board Mechanics & State Transitions

### 3.1 Logical Disappearance
- When a valid pair is tapped, both cells transition from active to `isCleared = true`.
- Matched numbers logically disappear, opening lines of sight for subsequent matches.

### 3.2 Add Numbers
- When no immediately visible moves remain, the player taps **Add Numbers**.
- The engine collects all active ($!isCleared$) cells in reading order.
- Exact duplicates of these remaining numbers are appended to the end of the grid, preserving relative order.
- Combo multiplier resets to $1\times$.

### 3.3 Board Compaction
- In Classic mode (with `autoCompactRows = true`), when an entire row of 9 cells becomes completely cleared, that row is collapsed.
- All subsequent rows shift upward, reducing vertical footprint while strictly preserving reading order.
- Clearing a row awards bonus points.

---

## 4. Scoring, Combos, and Rewards

| Action | Points | Economy Reward |
| :--- | :--- | :--- |
| Identical Match ($v_1 = v_2$) | 10 pts $\times$ Combo | — |
| Sum of Ten ($v_1 + v_2 = 10$) | 15 pts $\times$ Combo | — |
| Match Milestone (every 5 matches) | — | +5 Coins |
| Row Cleared (all 9 cells) | 50 pts | +10 Coins |
| Board Cleared (Victory) | 1,000 bonus pts | +75 Coins (Classic/Timed) / +150 Coins (Daily) |

### Combo Multiplier System
- Consecutive successful matches without an invalid tap increase the combo streak:
  $$\text{Combo} = \min(\text{Combo} + 1, 10)$$
- An invalid tap resets the combo multiplier immediately to $1\times$ and delivers negative haptic feedback.

---

## 5. Undo & Hints

- **Undo**: Restores previous board state, score, combo multiplier, and match counts from an in-memory snapshot stack.
- **Hint**: Algorithms scan the board for the first available valid pair. If none exist, the player is alerted to use Add Numbers. Hints cost 50 Coins.
