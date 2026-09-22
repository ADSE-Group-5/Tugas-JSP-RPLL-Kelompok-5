<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hasil — Persegi Panjang</title>
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
        .orb-1 { width: 500px; height: 500px; background: radial-gradient(circle, var(--accent-blue), transparent 70%); top: -15%; left: -10%; opacity: 0.3; }
        .orb-2 { width: 350px; height: 350px; background: radial-gradient(circle, var(--accent-green), transparent 70%); bottom: -10%; right: -5%; opacity: 0.25; }

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
            max-width: 520px;
            padding: 20px;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--text-secondary);
            text-decoration: none;
            font-size: 14px;
            margin-bottom: 28px;
            opacity: 0;
            transform: translateX(-20px);
            transition: color 0.3s ease-out;
        }
        .back-link:hover { color: var(--text-primary); }

        .page-header {
            text-align: center;
            margin-bottom: 32px;
            opacity: 0;
            transform: translateY(30px);
        }
        .page-header .icon { font-size: 40px; display: block; margin-bottom: 12px; }
        .page-header h1 {
            font-size: 26px; font-weight: 700;
            background: linear-gradient(135deg, #fff, var(--accent-blue));
            -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
        }

        /* SHAPE BADGE */
        .shape-badge {
            text-align: center;
            margin-bottom: 28px;
            opacity: 0;
            transform: scale(0.8) translateY(20px);
        }

        .shape-badge .badge {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 14px 28px;
            border-radius: 16px;
            font-size: 18px;
            font-weight: 700;
            letter-spacing: 1px;
            backdrop-filter: blur(12px);
        }

        .badge.bujursangkar {
            background: rgba(52, 211, 153, 0.1);
            border: 1px solid rgba(52, 211, 153, 0.25);
            color: var(--accent-green);
            box-shadow: 0 0 30px rgba(52, 211, 153, 0.1);
        }
        .badge.persegipanjang {
            background: rgba(79, 142, 255, 0.1);
            border: 1px solid rgba(79, 142, 255, 0.25);
            color: var(--accent-blue);
            box-shadow: 0 0 30px rgba(79, 142, 255, 0.1);
        }

        /* RESULT GLASS CARD */
        .glass-result {
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

        /* STATS GRID */
        .stats-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
            margin-bottom: 24px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.06);
            border-radius: 14px;
            padding: 20px;
            text-align: center;
            opacity: 0;
            transform: translateY(20px);
        }

        .stat-card .stat-label {
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            color: var(--text-muted);
            margin-bottom: 8px;
        }

        .stat-card .stat-value {
            font-size: 28px;
            font-weight: 700;
        }

        .stat-card.panjang .stat-value { color: var(--accent-blue); }
        .stat-card.lebar .stat-value { color: var(--accent-purple); }
        .stat-card.luas .stat-value { color: var(--accent-cyan); }
        .stat-card.keliling .stat-value { color: var(--accent-green); }

        /* FORMULA BREAKDOWN */
        .formula-breakdown {
            padding: 16px 18px;
            background: rgba(79, 142, 255, 0.05);
            border: 1px solid rgba(79, 142, 255, 0.1);
            border-radius: 12px;
            font-size: 13px;
            color: var(--text-secondary);
            line-height: 2;
            font-family: 'Consolas', monospace;
        }

        .formula-breakdown .highlight {
            color: var(--accent-cyan);
        }

        /* ACTION BUTTONS */
        .btn-row {
            display: flex;
            gap: 12px;
            margin-top: 24px;
        }

        .btn {
            flex: 1;
            padding: 14px;
            border-radius: 14px;
            border: none;
            font-size: 14px;
            font-weight: 600;
            font-family: inherit;
            text-decoration: none;
            text-align: center;
            cursor: pointer;
            transition: transform 0.3s ease-out, box-shadow 0.3s ease-out;
            will-change: transform;
        }

        .btn:hover { transform: translateY(-2px); }
        .btn:active { transform: translateY(0) scale(0.98); }

        .btn-secondary {
            background: rgba(255,255,255,0.06);
            color: var(--text-primary);
            border: 1px solid rgba(255,255,255,0.1);
        }
        .btn-primary {
            background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
            color: #fff;
            box-shadow: 0 6px 20px rgba(79, 142, 255, 0.2);
        }

        .particle {
            position: fixed; width: 3px; height: 3px;
            background: rgba(255,255,255,0.12); border-radius: 50%;
            pointer-events: none; z-index: 2;
        }

        @media (prefers-reduced-motion: reduce) {
            .glass-result, .page-header, .back-link, .shape-badge, .stat-card {
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
        String jenis = (String) request.getAttribute("jenis");
        double panjang = (Double) request.getAttribute("panjang");
        double lebar = (Double) request.getAttribute("lebar");
        double luas = (Double) request.getAttribute("luas");
        double keliling = (Double) request.getAttribute("keliling");
        boolean isBujurSangkar = jenis.equals("BUJUR SANGKAR");
    %>

    <div class="result-scene">
        <a href="index.jsp" class="back-link">← Menu Utama</a>

        <div class="page-header">
            <span class="icon"><%= isBujurSangkar ? "⬜" : "▬" %></span>
            <h1>Hasil Perhitungan</h1>
        </div>

        <div class="shape-badge">
            <span class="badge <%= isBujurSangkar ? "bujursangkar" : "persegipanjang" %>">
                <%= isBujurSangkar ? "◻" : "▭" %>&nbsp;&nbsp;<%= jenis %>
            </span>
        </div>

        <div class="glass-result">
            <div class="stats-grid">
                <div class="stat-card panjang">
                    <div class="stat-label">Panjang</div>
                    <div class="stat-value"><%= panjang %></div>
                </div>
                <div class="stat-card lebar">
                    <div class="stat-label">Lebar</div>
                    <div class="stat-value"><%= lebar %></div>
                </div>
                <div class="stat-card luas">
                    <div class="stat-label">Luas</div>
                    <div class="stat-value"><%= luas %></div>
                </div>
                <div class="stat-card keliling">
                    <div class="stat-label">Keliling</div>
                    <div class="stat-value"><%= keliling %></div>
                </div>
            </div>

            <div class="formula-breakdown">
                Luas = <span class="highlight"><%= panjang %></span> × <span class="highlight"><%= lebar %></span> = <span class="highlight"><%= luas %></span><br>
                Keliling = 2 × (<span class="highlight"><%= panjang %></span> + <span class="highlight"><%= lebar %></span>) = <span class="highlight"><%= keliling %></span>
            </div>

            <div class="btn-row">
                <a href="index.jsp" class="btn btn-secondary">← Menu</a>
                <a href="persegipanjang.jsp" class="btn btn-primary">Hitung Lagi →</a>
            </div>
        </div>
    </div>

    <script>
        const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
        if (!prefersReducedMotion) {
            gsap.to('.back-link', { opacity: 1, x: 0, duration: 0.8, ease: 'power3.out', delay: 0.1 });
            gsap.to('.page-header', { opacity: 1, y: 0, duration: 1, ease: 'power3.out', delay: 0.2 });
            gsap.to('.shape-badge', { opacity: 1, scale: 1, y: 0, duration: 0.8, ease: 'back.out(1.7)', delay: 0.5 });
            gsap.to('.glass-result', { opacity: 1, y: 0, rotateX: 0, duration: 1, ease: 'power3.out', delay: 0.6 });

            // Staggered stat cards
            gsap.to('.stat-card', {
                opacity: 1, y: 0, duration: 0.7,
                ease: 'power3.out', stagger: 0.1, delay: 0.9
            });

            gsap.to('.orb-1', { x: 30, y: 20, duration: 8, ease: 'sine.inOut', yoyo: true, repeat: -1 });
            gsap.to('.orb-2', { x: -20, y: -15, duration: 10, ease: 'sine.inOut', yoyo: true, repeat: -1 });

            // 3D tilt
            const card = document.querySelector('.glass-result');
            card.addEventListener('mousemove', e => {
                const rect = card.getBoundingClientRect();
                const rotateX = ((e.clientY - rect.top) - rect.height / 2) / 30;
                const rotateY = (rect.width / 2 - (e.clientX - rect.left)) / 30;
                gsap.to(card, { rotateX, rotateY, duration: 0.4, ease: 'power2.out', transformPerspective: 800 });
            });
            card.addEventListener('mouseleave', () => {
                gsap.to(card, { rotateX: 0, rotateY: 0, duration: 0.6, ease: 'power2.out' });
            });

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
