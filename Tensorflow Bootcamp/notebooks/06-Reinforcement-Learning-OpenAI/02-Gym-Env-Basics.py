# Gotta import gym!
import gym

# Make the environment, replace this string with any
# from the docs. (Some environments have dependencies)
env = gym.make('CartPole-v0')

# Reset the environment to default beginning
# Default observation variable
print("Initial Observation")
observation = env.reset()
print(observation)

print('\n')

stop = False
step_cnt = 0;
while not stop:
#for _ in range(2):

    step_cnt += 1
    # Show render
    #env.render()

    # Random Action
    action = env.action_space.sample()


    # Get the 4 observation values discussed
    observation, reward, done, info = env.step(action)
    stop = done

    if done:
        #print("Performed One Random Action")
        print("Performed seccess Action in {}".format(step_cnt))
        print('\n')
        print('observation')
        print(observation)
        print('\n')

        print('reward')
        print(reward)
        print('\n')

        print('done')
        print(done)
        print('\n')

        print('info')
        print(info)
        print('\n')




