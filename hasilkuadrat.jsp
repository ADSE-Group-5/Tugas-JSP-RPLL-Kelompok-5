<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hasil — Persamaan Kuadrat</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/gsap.min.js"></script>
    <style>
        *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }
        :root {
            --bg-deep: #0a0a1a;
            --glass-bg: rgba(255, 255, 255, 0.04);
            --glass-border: rgba(255, 255, 255, 0.08);
            --accent-blue: #4f8eff;
            --accent-purple: #a855f7;
            --accent-cyan: #22d3ee;
            --accent-green: #34d399;
            --accent-amber: #fbbf24;
            --accent-rose: #fb7185;
            --text-primary: rgba(255, 255, 255, 0.92);
            --text-secondary: rgba(255, 255, 255, 0.55);
            --text-muted: rgba(255, 255, 255, 0.35);
            --shadow-float: 0 20px 60px rgba(0, 0, 0, 0.4);
            --radius: 20px;
            --blur: 16px;
        }

        body {
            font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, sans-serif;
            background: var(--bg-deep);
            color: var(--text-primary);
            min-height: 100vh;
            overflow-x: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            perspective: 1200px;
        }

        .spatial-bg { position: fixed; inset: 0; z-index: 0; overflow: hidden; }
        .orb { position: absolute; border-radius: 50%; filter: blur(80px); will-change: transform; }
        .orb-1 { width: 450px; height: 450px; background: radial-gradient(circle, var(--accent-purple), transparent 70%); top: -15%; right: -10%; opacity: 0.3; }
        .orb-2 { width: 350px; height: 350px; background: radial-gradient(circle, var(--accent-cyan), transparent 70%); bottom: -10%; left: -5%; opacity: 0.25; }

        .grid-overlay {
            position: fixed; inset: 0; z-index: 1;
            background-image:
                linear-gradient(rgba(255,255,255,0.015) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255,255,255,0.015) 1px, transparent 1px);
            background-size: 60px 60px;
            transform: perspective(800px) rotateX(60deg);
            transform-origin: center top;
            opacity: 0.5;
            mask-image: linear-gradient(to bottom, transparent, black 30%, black 70%, transparent);
        }

        .result-scene {
            position: relative;
            z-index: 10;
            width: 100%;
            max-width: 540px;
            padding: 20px;
        }

        .back-link {
            display: inline-flex; align-items: center; gap: 8px;
            color: var(--text-secondary); text-decoration: none; font-size: 14px;
            margin-bottom: 28px; opacity: 0; transform: translateX(-20px);
            transition: color 0.3s ease-out;
        }
        .back-link:hover { color: var(--text-primary); }

        .page-header {
            text-align: center; margin-bottom: 28px;
            opacity: 0; transform: translateY(30px);
        }
        .page-header .icon { font-size: 40px; display: block; margin-bottom: 12px; }
        .page-header h1 {
            font-size: 26px; font-weight: 700;
            background: linear-gradient(135deg, #fff, var(--accent-purple));
            -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
        }

        /* EQUATION DISPLAY */
        .equation-bar {
            text-align: center; margin-bottom: 20px;
            opacity: 0; transform: translateY(20px);
        }
        .equation-bar .eq {
            display: inline-block;
            font-size: 18px; font-weight: 600;
            font-family: 'Consolas', monospace;
            padding: 12px 24px;
            background: rgba(168, 85, 247, 0.08);
            border: 1px solid rgba(168, 85, 247, 0.15);
            border-radius: 12px;
            color: var(--accent-purple);
        }

        /* DISCRIMINANT BADGE */
        .disc-badge {
            text-align: center; margin-bottom: 24px;
            opacity: 0; transform: scale(0.8) translateY(20px);
        }
        .disc-badge .badge {
            display: inline-flex; align-items: center; gap: 10px;
            padding: 12px 24px; border-radius: 14px;
            font-size: 15px; font-weight: 700;
            backdrop-filter: blur(12px);
            letter-spacing: 0.5px;
        }
        .badge.d-positif {
            background: rgba(52, 211, 153, 0.1);
            border: 1px solid rgba(52, 211, 153, 0.25);
            color: var(--accent-green);
            box-shadow: 0 0 30px rgba(52, 211, 153, 0.08);
        }
        .badge.d-nol {
            background: rgba(251, 191, 36, 0.1);
            border: 1px solid rgba(251, 191, 36, 0.25);
            color: var(--accent-amber);
            box-shadow: 0 0 30px rgba(251, 191, 36, 0.08);
        }
        .badge.d-negatif {
            background: rgba(251, 113, 133, 0.1);
            border: 1px solid rgba(251, 113, 133, 0.25);
            color: var(--accent-rose);
            box-shadow: 0 0 30px rgba(251, 113, 133, 0.08);
        }

        /* ERROR STATE */
        .error-card {
            background: rgba(251, 113, 133, 0.06);
            border: 1px solid rgba(251, 113, 133, 0.2);
            border-radius: var(--radius);
            padding: 32px;
            text-align: center;
            backdrop-filter: blur(var(--blur));
            opacity: 0;
            transform: translateY(40px);
        }
        .error-card .error-icon { font-size: 48px; margin-bottom: 16px; display: block; }
        .error-card .error-msg { font-size: 16px; color: var(--accent-rose); font-weight: 600; }

        /* GLASS RESULT CARD */
        .glass-result {
            position: relative;
            background: var(--glass-bg);
            border: 1px solid var(--glass-border);
            border-radius: var(--radius);
            padding: 32px;
            backdrop-filter: blur(var(--blur));
            -webkit-backdrop-filter: blur(var(--blur));
            box-shadow: var(--shadow-float);
            opacity: 0;
            transform: translateY(50px) rotateX(6deg);
            will-change: transform;
        }
        .glass-result::before {
            content: ''; position: absolute; inset: 0;
            border-radius: var(--radius);
            background: linear-gradient(135deg, rgba(255,255,255,0.05) 0%, transparent 50%);
            pointer-events: none;
        }

        /* STATS */
        .stats-row {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 12px;
            margin-bottom: 20px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.06);
            border-radius: 12px;
            padding: 16px 12px;
            text-align: center;
            opacity: 0;
            transform: translateY(20px);
        }
        .stat-card .stat-label {
            font-size: 11px; font-weight: 600;
            text-transform: uppercase; letter-spacing: 1.2px;
            color: var(--text-muted); margin-bottom: 6px;
        }
        .stat-card .stat-value {
            font-size: 22px; font-weight: 700;
            font-family: 'Consolas', monospace;
        }
        .stat-card.val-a .stat-value { color: var(--accent-purple); }
        .stat-card.val-b .stat-value { color: var(--accent-blue); }
        .stat-card.val-c .stat-value { color: var(--accent-cyan); }

        /* DISCRIMINANT DISPLAY */
        .disc-display {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            padding: 16px;
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.06);
            border-radius: 12px;
            margin-bottom: 20px;
            font-family: 'Consolas', monospace;
        }
        .disc-display .disc-label {
            font-size: 13px; color: var(--text-secondary);
        }
        .disc-display .disc-value {
            font-size: 22px; font-weight: 700;
        }

        /* ROOT RESULTS */
        .roots-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
            margin-bottom: 24px;
        }

        .root-card {
            position: relative;
            padding: 20px;
            text-align: center;
            border-radius: 14px;
            overflow: hidden;
            opacity: 0;
            transform: translateY(20px) scale(0.95);
        }
        .root-card::before {
            content: ''; position: absolute; inset: 0;
            border-radius: 14px;
            pointer-events: none;
        }
        .root-card.x1 {
            background: rgba(79, 142, 255, 0.06);
            border: 1px solid rgba(79, 142, 255, 0.15);
        }
        .root-card.x2 {
            background: rgba(168, 85, 247, 0.06);
            border: 1px solid rgba(168, 85, 247, 0.15);
        }
        .root-card .root-label {
            font-size: 12px; font-weight: 600;
            text-transform: uppercase; letter-spacing: 1.5px;
            margin-bottom: 8px;
        }
        .root-card.x1 .root-label { color: var(--accent-blue); }
        .root-card.x2 .root-label { color: var(--accent-purple); }
        .root-card .root-value {
            font-size: 22px; font-weight: 700;
            font-family: 'Consolas', monospace;
            color: var(--text-primary);
            word-break: break-all;
        }

        /* FORMULA BREAKDOWN */
        .formula-breakdown {
            padding: 16px 18px;
            background: rgba(168, 85, 247, 0.05);
            border: 1px solid rgba(168, 85, 247, 0.1);
            border-radius: 12px;
            font-size: 13px; color: var(--text-secondary);
            line-height: 2;
            font-family: 'Consolas', monospace;
        }
        .formula-breakdown .hl { color: var(--accent-cyan); }

        /* BUTTONS */
        .btn-row { display: flex; gap: 12px; margin-top: 24px; }
        .btn {
            flex: 1; padding: 14px; border-radius: 14px; border: none;
            font-size: 14px; font-weight: 600; font-family: inherit;
            text-decoration: none; text-align: center; cursor: pointer;
            transition: transform 0.3s ease-out, box-shadow 0.3s ease-out;
            will-change: transform;
        }
        .btn:hover { transform: translateY(-2px); }
        .btn:active { transform: translateY(0) scale(0.98); }
        .btn-secondary {
            background: rgba(255,255,255,0.06); color: var(--text-primary);
            border: 1px solid rgba(255,255,255,0.1);
        }
        .btn-primary {
            background: linear-gradient(135deg, var(--accent-purple), var(--accent-blue));
            color: #fff; box-shadow: 0 6px 20px rgba(168, 85, 247, 0.2);
        }

        .particle {
            position: fixed; width: 3px; height: 3px;
            background: rgba(255,255,255,0.12); border-radius: 50%;
            pointer-events: none; z-index: 2;
        }

        @media (prefers-reduced-motion: reduce) {
            .glass-result, .page-header, .back-link, .disc-badge,
            .equation-bar, .stat-card, .root-card, .error-card {
                opacity: 1 !important; transform: none !important; transition: none !important;
            }
            .orb, .particle { display: none; }
            .grid-overlay { transform: none; }
        }
    </style>
</head>
<body>

    <div class="spatial-bg">
        <div class="orb orb-1"></div>
        <div class="orb orb-2"></div>
    </div>
    <div class="grid-overlay"></div>

    <%
        String error = (String) request.getAttribute("error");
    %>

    <div class="result-scene">
        <a href="index.jsp" class="back-link">← Menu Utama</a>

        <div class="page-header">
            <span class="icon">📊</span>
            <h1>Hasil Persamaan Kuadrat</h1>
        </div>

        <% if (error != null) { %>

            <div class="error-card">
                <span class="error-icon">⚠️</span>
                <p class="error-msg"><%= error %></p>
            </div>
            <div class="btn-row" style="margin-top:24px;">
                <a href="index.jsp" class="btn btn-secondary">← Menu</a>
                <a href="persamaankuadrat.jsp" class="btn btn-primary">Coba Lagi →</a>
            </div>

        <% } else {
            double a = (Double) request.getAttribute("a");
            double b = (Double) request.getAttribute("b");
            double c = (Double) request.getAttribute("c");
            double diskriminan = (Double) request.getAttribute("diskriminan");
            String jenisAkar = (String) request.getAttribute("jenisAkar");
            String hasilX1 = (String) request.getAttribute("hasilX1");
            String hasilX2 = (String) request.getAttribute("hasilX2");

            String dClass;
            String dColor;
            if (diskriminan > 0) { dClass = "d-positif"; dColor = "#34d399"; }
            else if (diskriminan == 0) { dClass = "d-nol"; dColor = "#fbbf24"; }
            else { dClass = "d-negatif"; dColor = "#fb7185"; }
        %>

            <div class="equation-bar">
                <span class="eq"><%= a %>x² + (<%= b %>)x + (<%= c %>) = 0</span>
            </div>

            <div class="disc-badge">
                <span class="badge <%= dClass %>">
                    <%= jenisAkar %>
                </span>
            </div>

            <div class="glass-result">
                <div class="stats-row">
                    <div class="stat-card val-a">
                        <div class="stat-label">a</div>
                        <div class="stat-value"><%= a %></div>
                    </div>
                    <div class="stat-card val-b">
                        <div class="stat-label">b</div>
                        <div class="stat-value"><%= b %></div>
                    </div>
                    <div class="stat-card val-c">
                        <div class="stat-label">c</div>
                        <div class="stat-value"><%= c %></div>
                    </div>
                </div>

                <div class="disc-display">
                    <span class="disc-label">D = b² - 4ac =</span>
                    <span class="disc-value" style="color: <%= dColor %>"><%= diskriminan %></span>
                </div>

                <div class="roots-grid">
                    <div class="root-card x1">
                        <div class="root-label">X₁</div>
                        <div class="root-value"><%= hasilX1 %></div>
                    </div>
                    <div class="root-card x2">
                        <div class="root-label">X₂</div>
                        <div class="root-value"><%= hasilX2 %></div>
                    </div>
                </div>

                <div class="formula-breakdown">
                    D = (<span class="hl"><%= b %></span>)² - 4(<span class="hl"><%= a %></span>)(<span class="hl"><%= c %></span>) = <span class="hl"><%= diskriminan %></span><br>
                    x = (-b ± √D) / 2a
                </div>

                <div class="btn-row">
                    <a href="index.jsp" class="btn btn-secondary">← Menu</a>
                    <a href="persamaankuadrat.jsp" class="btn btn-primary">Hitung Lagi →</a>
                </div>
            </div>

        <% } %>
    </div>

    <script>
        const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
        if (!prefersReducedMotion) {
            gsap.to('.back-link', { opacity: 1, x: 0, duration: 0.8, ease: 'power3.out', delay: 0.1 });
            gsap.to('.page-header', { opacity: 1, y: 0, duration: 1, ease: 'power3.out', delay: 0.2 });

            <% if (error != null) { %>
                gsap.to('.error-card', { opacity: 1, y: 0, duration: 0.8, ease: 'back.out(1.7)', delay: 0.4 });
            <% } else { %>
                gsap.to('.equation-bar', { opacity: 1, y: 0, duration: 0.8, ease: 'power3.out', delay: 0.35 });
                gsap.to('.disc-badge', { opacity: 1, scale: 1, y: 0, duration: 0.8, ease: 'back.out(1.7)', delay: 0.5 });
                gsap.to('.glass-result', { opacity: 1, y: 0, rotateX: 0, duration: 1, ease: 'power3.out', delay: 0.6 });
                gsap.to('.stat-card', { opacity: 1, y: 0, duration: 0.6, ease: 'power3.out', stagger: 0.08, delay: 0.9 });
                gsap.to('.root-card', { opacity: 1, y: 0, scale: 1, duration: 0.7, ease: 'back.out(1.4)', stagger: 0.12, delay: 1.2 });

                const card = document.querySelector('.glass-result');
                if (card) {
                    card.addEventListener('mousemove', e => {
                        const rect = card.getBoundingClientRect();
                        const rotateX = ((e.clientY - rect.top) - rect.height / 2) / 35;
                        const rotateY = (rect.width / 2 - (e.clientX - rect.left)) / 35;
                        gsap.to(card, { rotateX, rotateY, duration: 0.4, ease: 'power2.out', transformPerspective: 800 });
                    });
                    card.addEventListener('mouseleave', () => {
                        gsap.to(card, { rotateX: 0, rotateY: 0, duration: 0.6, ease: 'power2.out' });
                    });
                }
            <% } %>

            gsap.to('.orb-1', { x: -25, y: 20, duration: 9, ease: 'sine.inOut', yoyo: true, repeat: -1 });
            gsap.to('.orb-2', { x: 20, y: -15, duration: 11, ease: 'sine.inOut', yoyo: true, repeat: -1 });

            for (let i = 0; i < 12; i++) {
                const p = document.createElement('div');
                p.classList.add('particle');
                p.style.left = Math.random() * 100 + 'vw';
                p.style.top = Math.random() * 100 + 'vh';
                document.body.appendChild(p);
                gsap.to(p, { y: -80 - Math.random() * 100, opacity: 0, duration: 4 + Math.random() * 5, ease: 'none', repeat: -1, delay: Math.random() * 4 });
            }
        }
    </script>
</body>
</html>
