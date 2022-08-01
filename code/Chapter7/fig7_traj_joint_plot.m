close all; clear;

abb = loadrobot("abbIrb1600", DataFormat="row");
aIK = analyticalInverseKinematics(abb);
abbIKFcn = aIK.generateIKFunction("ikIRB1600");

TE1 = se3(trvec2tform([0.6 -0.5 0.1])) * se3(tformrx(3));
TE2 = se3(trvec2tform([0.4 0.5 0.1])) * se3(tformrx(2));
sol1 = abbIKFcn(TE1.tform);
sol2 = abbIKFcn(TE2.tform);

waypts = [sol1(1,:)', sol2(1,:)'];
t = 0:0.02:2;

q = quinticpolytraj(waypts, [0 2], t);
q = q';

%% Subfigure (a) - Joint coordinates vs. time
figure;
xplot(t, q);
l = legend;
l.Location = "none";
l.Position = [0.7659    0.4535    0.1232    0.3];
l.FontSize = 12;

rvcprint("painters", subfig="_a", thicken=2, figy=150)

%% Subfigure (b) - End effector position vs. time
figure
for i = 1:size(q,1)
    T(i) = se3(abb.getTransform(q(i,:), "tool0"));
end
p = T.trvec;
plot(t, p)
grid on
ylabel('Position (m)')
xlabel('Time (s)')
l = legend('x', 'y', 'z', 'Location', 'SouthEast');
set(l, 'FontSize', 12)

rvcprint("painters", subfig="_b", thicken=2, figy=150)

%% Subfigure (c) - y vs. x
figure
plot(p(:,1), p(:,2))
xlabel('x (m)')
ylabel('y (m)');
hold on
plot2(p(1,:), 'o', 'MarkerFaceColor', 'k', 'MarkerSize', 12, 'MarkerEdgeColor', 'none')
plot2(p(end,:), 'h', 'MarkerFaceColor', 'k', 'MarkerSize', 16, 'MarkerEdgeColor', 'none')
hold off
ylim([-0.55 0.55])
axis equal
grid on

rvcprint("painters", subfig="_c", thicken=2, figy=50)

%% Subfigure (d) - RPY vs. time
figure
plot(t, tform2eul(T.tform, "xyz"))
grid
ylabel('RPY angles (rad)');
xlabel('Time (s)')
l = legend('roll', 'pitch', 'yaw');
set(l, 'FontSize', 12)
grid on

rvcprint("painters", subfig="_d", thicken=2, figy=150)
