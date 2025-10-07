# Traffic-Light-Contol-using-Verilog-FSM

<h1>🚦 Traffic Light Controller using Verilog (FSM Project)</h1>

<p>
  <b>A Finite State Machine (FSM)-based Traffic Signal Controller</b><br>
  Designed using <b>Verilog HDL</b> to manage traffic flow between a Highway and a Country road.
</p>

---

## 📘 Project Overview

This project implements a **Traffic Light Controller** using a **Moore Finite State Machine (FSM)** in **Verilog HDL**.

The system controls traffic at a **two-way intersection** (Highway & Country Road), where:
- The **Highway** has priority (green by default) because it has the higher chances of cars passing through.
- A sensor input is installed in the country side "X" which detects whether a vehicle is waiting or not
- If X = 1 ==> means a vehicle is waiting on the countryside road
- If X = 0 ==> means the countryside is free and no vehicles are present.
- The **Country Road** gets green only when a vehicle is detected (`X = 1`)
- Timed transitions ensure realistic yellow and all-red delays

## 🧠 Key Features

✅ FSM with **5 defined states (S0–S4)**  
✅ **Moore Machine** — outputs depend only on the current state  
✅ **Delay counter** for realistic yellow and all-red phases  
✅ **Active-low reset (`rst_n`)** for safe startup  
✅ Clean, modular Verilog coding style  
✅ **Easily synthesizable** on FPGA or simulatable with ModelSim / GTKWave

## Binary Codes for the traffic lights 
<img width="926" height="263" alt="image" src="https://github.com/user-attachments/assets/5a7aeb59-bd96-4c7f-ae8b-a7ceb033ac02" />


## ⚙️ State Definitions

<img width="1017" height="632" alt="image" src="https://github.com/user-attachments/assets/c500ad8d-627b-4112-8727-1b504f2698a5" />

## FLOWCHART REPRESENTATION 

<img width="521" height="770" alt="image" src="https://github.com/user-attachments/assets/48c77911-d161-4763-a76e-7bc1a57bc3a6" />

## ⏱️ Timing Delays

<table align="center">
  <thead>
    <tr>
      <th>Phase</th>
      <th>State</th>
      <th>Highway Light</th>
      <th>Country Light</th>
      <th>Delay Value (clock cycles)</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Highway Yellow → Red</b></td>
      <td><code>S1</code></td>
      <td>🟡 Yellow</td>
      <td>🔴 Red</td>
      <td><b>3</b> (<code>Y2R_DELAY</code>)</td>
      <td>Warns highway vehicles to slow down before red</td>
    </tr>
    <tr>
      <td><b>All-Red Safety Pause</b></td>
      <td><code>S2</code></td>
      <td>🔴 Red</td>
      <td>🔴 Red</td>
      <td><b>2</b> (<code>R2G_DELAY</code>)</td>
      <td>Both roads red to avoid collisions</td>
    </tr>
    <tr>
      <td><b>Country Yellow → Red</b></td>
      <td><code>S4</code></td>
      <td>🔴 Red</td>
      <td>🟡 Yellow</td>
      <td><b>3</b> (<code>Y2R_DELAY</code>)</td>
      <td>Warns country road vehicles to stop before returning to highway green</td>
    </tr>
  </tbody>
</table>

<p align="center">
  ⏳ <b>Total Delay Cycle:</b> 3 + 2 + 3 = <b>8 clock cycles</b> per full transition
</p>
<img width="825" height="301" alt="image" src="https://github.com/user-attachments/assets/6fe2f7cc-0787-4a93-9e96-55e3d18a0f79" />

## TABULAR REPRESENTATION OF HOW THE ENTIRE SYSTEM WORKS

<img width="875" height="472" alt="image" src="https://github.com/user-attachments/assets/3ed300e0-5926-474b-9647-5ecca6e3be5d" />

## 🧪Tabular Results

<p>The following table shows the console output captured from the Verilog testbench.  
Each row corresponds to one observed moment in the simulation (in nanoseconds),  
showing the sensor input `X` and the traffic-light outputs for both roads.</p>
<img width="965" height="571" alt="image" src="https://github.com/user-attachments/assets/56647045-1f4a-4b3d-8acb-aa6ba1dd6027" />
<img width="963" height="489" alt="image" src="https://github.com/user-attachments/assets/6c3f6f82-fc52-4e14-8914-7edce5d58b2f" />

## Simulation Results

<img width="468" height="557" alt="image" src="https://github.com/user-attachments/assets/6cf3f713-bc77-42fe-8f8f-40522d48e70c" />


<img width="1915" height="1025" alt="image" src="https://github.com/user-attachments/assets/32d14565-e807-4036-93a4-9204efac34a4" />
<img width="919" height="443" alt="image" src="https://github.com/user-attachments/assets/97ce12de-42a6-43a2-b0ec-3a0e9a4a959b" />


