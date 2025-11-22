import argparse
import os
import sys

# File to store tasks
FILE_NAME = "tasks.txt"
verbose = False


def get_argsparser():
    parser = argparse.ArgumentParser(description="manage task list")
    group = parser.add_mutually_exclusive_group()
    group.add_argument("-v", "--verbose", action="store_true", help="enable verbose output")
    group.add_argument("-i", "--interactive", action="store_true", help="manage the task list interactively")
    subparsers = parser.add_subparsers(dest='command', help='subcommand help')
    
    parser_add = subparsers.add_parser('add', aliases=['a'], help='add a task')
    parser_add.add_argument("-t", "--title", help="task title", required=True)
    parser_add.add_argument("-p", "--priority", help="task priority", required=True)
    parser_add.add_argument("-d", "--due-date", help="task due date", required=True)

    parser_view = subparsers.add_parser('view', aliases=['v', 'vue'], help='view all tasks')

    parser_close = subparsers.add_parser('close', aliases=['c', 'complete'], help='mark a task complete')
    parser_close.add_argument("task_id", help="ID of task to mark complete")

    parser_delete = subparsers.add_parser('delete', aliases=['d', 'del'], help="delete a task")
    parser_delete.add_argument("task_id", help="ID of task to delete")

    parser_export = subparsers.add_parser('export', aliases=['e', 'x', 'exp'], help="export the task list")
    parser_export.add_argument("-m", "--format", choices=['json', 'csv'], help="export format", default='csv')
    parser_export.add_argument("-f", "--filename-prefix", help="export filename prefix", required=True)

    return parser


# Load tasks from file
def load_tasks():
    tasks = {}
    if os.path.exists(FILE_NAME):
        with open(FILE_NAME, 'r') as file:
            for line in file:
                task_id, title, status, priority, due_date = line.strip().split(' | ')
                tasks[int(task_id)] = {'title': title, 'status': status, 'priority': priority, 'due_date': due_date}
    return tasks


# Save tasks to file
def save_tasks(tasks):
    with open(FILE_NAME, 'w') as file:
        for task_id, task in tasks.items():
            file.write(f"{task_id} | {task['title']} | {task['status']} | {task['priority']} | {task['due_date']}\n")


def add_task(tasks, title, priority, due_date):
    task_id = max(tasks.keys(), default=0) + 1
    status = 'incomplete'
    tasks[task_id] = {'title': title, 'status': status, 'priority': priority, 'due_date': due_date}
    if verbose:
        print(f"added task: title[{title}] status[{status}] priority[{priority}] due_date[{due_date}]")


def add_task_interact(tasks):
    title = input('Enter task title: ')
    priority = input('Enter task priority: ')
    due_date = input('Enter task due date: ')
    add_task(tasks, title, priority, due_date)
    print(f'Task "{title}" added.')


def view_tasks(tasks):
    if not tasks:
        print("No tasks available.")
    else:
        for task_id, task in tasks.items():
            print(f"[{task_id}] {task['title']} - {task['status']} - {task['priority']} - {task['due_date']}")
                

def mark_task_complete(tasks, task_id):
    tasks[task_id]['status'] = 'complete'
    if verbose:
        print(f"marked task complete with task_id {task_id}")


def mark_task_complete_interact(tasks):
    task_id = int(input("Enter task ID to mark as complete: "))
    if task_id in tasks:
        mark_task_complete(tasks, task_id)
        print(f"Task \"{tasks[task_id]['title']}\" marked as complete.")
    else:
        print(f'Task ID {task_id} not found.')


def delete_task(tasks, task_id):
    deleted_task = tasks.pop(task_id)
    if verbose:
        print(f"deleted task with task_id {task_id}")


def delete_task_interact(tasks):
    task_id = int(input("Enter task ID to delete: "))
    if task_id in tasks:
        print(f"Task to delete: {tasks[task_id]['title']}")
        yesOrNo = input('Are you sure you want to delete this task? (y/n): ')
        if yesOrNo and yesOrNo[0].lower() == 'n':
            print(f'Task {task_id} not deleted.')
            return
        deleted_task = tasks[task_id]
        delete_task(tasks, task_id)
        print(f'Task {deleted_task['title']} deleted.')
    else:
        print(f'Task ID {task_id} not found.')


def export_tasks(tasks, format, filename_prefix):
    export_filename = f'{export_filename}.{format}'
    if format == 'json':
        with open(export_filename, 'w') as file:
            file.write('{\n  "tasks":\n  [\n')
            count = 1
            for task_id, task in tasks.items():
                file.write("    {\n")
                file.write(f"      \"taskId\": \"{task_id}\",\n")
                file.write(f"      \"title\": \"{task['title']}\",\n")
                file.write(f"      \"status\": \"{task['status']}\",\n")
                file.write(f"      \"priority\": \"{task['priority']}\",\n")
                file.write(f"      \"dueDate\": \"{task['due_date']}\",\n")

                if count == len(tasks):
                    file.write('    }\n')
                else:
                    file.write('    },\n')
                    count += 1
                    
            file.write('  ]\n}\n')
          
    elif format == 'csv':
        with open(export_filename, 'w') as file:
            file.write('"Task ID", "Title", "Status", "Priority", "Due Date"\n')
            for task_id, task in tasks.items():
                file.write(f"\"{task_id}\", \"{task['title']}\", \"{task['status']}\", \"{task['priority']}\", \"{task['due_date']}\"\n")

    else:
        if verbose:
            print(f'failed export, unexpected format: {format}')
        return
    
    if verbose:
        print(f'Tasks successfully exported to {format.upper()} file named "{filename_prefix}.{format}"')


def export_tasks_interact(tasks):
    export_filename = input("Enter export filename prefix: ")
    file_type = input("Choose export to (J)SON or (C)SV: ")
    if file_type.lower() == 'j':
        export_tasks('json', export_filename)
    elif file_type.lower() == 'c':
        export_tasks('csv', export_filename)
    else:
       print('Invalid file type chosen, please try again')


def run_interactive(tasks):
    while True:
        print('\nTask Manager Menu:')
        print('1. Add Task')
        print('2. View Task')
        print('3. Mark Task Complete')
        print('4. Delete Task')
        print('5. Export Tasks to Datafile')
        print('6. Exit')
        choice = input("Enter your choice: ")
        
        if choice == "1":
            add_task_interact(tasks)
        elif choice == '2':
            view_tasks(tasks)
        elif choice == '3':
            mark_task_complete_interact(tasks)
        elif choice == '4':
            delete_task_interact(tasks)
        elif choice == '5':
            export_tasks_interact(tasks)
        elif choice == '6':
            print('Goodbye')
            break
        else:
            print('Invalid choice, please try again')


def main():
    parser = get_argsparser()
    args = parser.parse_args()

    global verbose
    verbose = args.verbose
    
    tasks = load_tasks()

    if args.interactive:
        run_interactive(tasks)
    elif args.command in ['view', 'vue', 'v']:
        view_tasks(tasks)
    elif args.command in ['add', 'a']:
        add_task(tasks, args.title, args.priority, args.due_date)
    elif args.command in ['close', 'complete', 'c']:
        mark_task_complete(tasks, int(args.task_id))
    elif args.command in ['delete', 'del', 'd']:
        delete_task(tasks, int(args.task_id))
    elif args.command in ['export', 'exp', 'e', 'x']:
        export_tasks(tasks, args.format, args.filename_prefix)
    else:
        print(f'ERROR unhandled command: {args.command}')
        
    save_tasks(tasks)


if __name__ == '__main__':
    main()
